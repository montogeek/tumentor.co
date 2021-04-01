defmodule TumentorWeb.UserSettingsController do
  use TumentorWeb, :controller

  alias Tumentor.Accounts
  alias TumentorWeb.UserAuth

  plug :assign_email_and_password_changesets

  def edit(conn, _params) do
    HTTPoison.start()

    headers = [Authorization: "Bearer #{TumentorWeb.Endpoint.config(:calendly_token)}"]

    case HTTPoison.get("https://api.calendly.com/users/me", headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, %{"resource" => %{"uri" => user_uri}}} = Jason.decode(body)

        case HTTPoison.get("https://api.calendly.com/event_types?user=#{user_uri}", headers) do
          {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
            {:ok, %{"collection" => calendars}} = Jason.decode(body)

            calendar =
              Enum.find(calendars, fn calendar ->
                calendar["active"]
              end)

            %{"uri" => uri} = calendar

            event_uri = List.last(Regex.run(~r/event_types\/(.*)/, uri))

            case HTTPoison.get(
                   "https://calendly.com/api/booking/event_types/#{event_uri}/calendar/range?timezone=Europe%2FBerlin&range_start=2021-04-01&range_end=2021-04-30",
                   headers
                 ) do
              {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
                {:ok, %{"days" => days}} = Jason.decode(body)

                availability =
                  days
                  # |> Enum.take(2)
                  |> Enum.reject(fn day -> length(day["spots"]) == 0 end)
                  |> Enum.map(fn day ->
                    {:ok, date} = Date.from_iso8601(day["date"])

                    %{
                      "date" => date,
                      "slots" =>
                        Enum.map(day["spots"], fn spot ->
                          if spot["status"] === "available" do
                            {:ok, date, offset} = DateTime.from_iso8601(spot["start_time"])
                            DateTime.add(date, offset)
                          end
                        end)
                    }
                  end)

                render(conn, "edit.html", availability: availability)

              {:ok, %HTTPoison.Response{status_code: 404}} ->
                IO.puts("Not found :(")

              {:error, %HTTPoison.Error{reason: reason}} ->
                IO.inspect(reason)
            end

          {:ok, %HTTPoison.Response{status_code: 404}} ->
            IO.puts("Not found :(")

          {:error, %HTTPoison.Error{reason: reason}} ->
            IO.inspect(reason)
        end

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end

  def update(conn, %{"action" => "update_email"} = params) do
    %{"current_password" => password, "user" => user_params} = params
    user = conn.assigns.current_user

    case Accounts.apply_user_email(user, password, user_params) do
      {:ok, applied_user} ->
        Accounts.deliver_update_email_instructions(
          applied_user,
          user.email,
          &Routes.user_settings_url(conn, :confirm_email, &1)
        )

        conn
        |> put_flash(
          :info,
          "A link to confirm your email change has been sent to the new address."
        )
        |> redirect(to: Routes.user_settings_path(conn, :edit))

      {:error, changeset} ->
        render(conn, "edit.html", email_changeset: changeset)
    end
  end

  def update(conn, %{"action" => "update_password"} = params) do
    %{"current_password" => password, "user" => user_params} = params
    user = conn.assigns.current_user

    case Accounts.update_user_password(user, password, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Password updated successfully.")
        |> put_session(:user_return_to, Routes.user_settings_path(conn, :edit))
        |> UserAuth.log_in_user(user)

      {:error, changeset} ->
        render(conn, "edit.html", password_changeset: changeset)
    end
  end

  def confirm_email(conn, %{"token" => token}) do
    case Accounts.update_user_email(conn.assigns.current_user, token) do
      :ok ->
        conn
        |> put_flash(:info, "Email changed successfully.")
        |> redirect(to: Routes.user_settings_path(conn, :edit))

      :error ->
        conn
        |> put_flash(:error, "Email change link is invalid or it has expired.")
        |> redirect(to: Routes.user_settings_path(conn, :edit))
    end
  end

  defp assign_email_and_password_changesets(conn, _opts) do
    user = conn.assigns.current_user

    conn
    |> assign(:email_changeset, Accounts.change_user_email(user))
    |> assign(:password_changeset, Accounts.change_user_password(user))
  end
end
