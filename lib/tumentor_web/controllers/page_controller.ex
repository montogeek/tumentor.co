defmodule TumentorWeb.PageController do
  use TumentorWeb, :controller

  defp normalize_topics(topics) do
    case topics do
      nil -> ""
      _ -> Enum.map(topics, fn {_k, v} -> v end) |> Enum.join(" ")
    end
  end

  def index(conn, _params) do
    reg =
      Regex.run(
        # ~r/^https:\/\/calendly.com\/.+/,
        ~r/[a-z]+:\/\/[^ ]+/,
        "https://calendly.com/alvaroagamezlicha/15min"
      )

    mentors = Tumentor.Mentors.list_mentors()

    mentors =
      Enum.map(mentors, fn mentor ->
        path =
          case URI.parse(mentor.schedule_url || "") do
            %URI{path: path} -> path
          end

        %{mentor | topics: normalize_topics(Map.get(mentor, :topics)), schedule_url: path}
      end)

    render(conn, "index.html", mentors: mentors)
  end
end
