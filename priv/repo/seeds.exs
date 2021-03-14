# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tumentor.Repo.insert!(%Tumentor.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Tumentor.Repo

defmodule Seeds do
  def string_to_map(string) do
    String.split(string, ",")
    |> Enum.with_index(1)
    |> Enum.map(fn {k, v} -> {v, k} end)
    |> Map.new()
  end
end

# Extracted from https://www.notion.so/7e03d5ff94c94605a0f148a0e4c7502e?v=3e47d53cf0354755bdd3f6ea5886ab8b on 14.03.2021 21:26

initial_mentors = [
  %Tumentor.Mentors.Mentor{
    name: "Pablo España",
    topics:
      Seeds.string_to_map(
        "Backend Development,Desarrollo web,JavaScript,Node.js,Resume,Web Development"
      ),
    github_url: "https://github.com/pabloespanab",
    schedule_url: "https://calendly.com/pabloespanab/30min"
  },
  %Tumentor.Mentors.Mentor{
    name: "Wbert Adrián Castro Vera",
    topics: Seeds.string_to_map("Desarrollo web,JavaScript,entrevistas"),
    github_url: "https://github.com/dobleuber",
    schedule_url: "https://calendly.com/dobleuber/60min"
  },
  %Tumentor.Mentors.Mentor{
    name: "Giovanny Beltran - agar3s",
    topics: Seeds.string_to_map("Desarrollo de videojuegos,Desarrollo web,JavaScript"),
    github_url: "https://github.com/agar3s",
    schedule_url: "https://doodle.com/poll/f6hm63pc7ynt254m"
  },
  %Tumentor.Mentors.Mentor{
    name: "Yeison Daza",
    schedule_url: "https://calendly.com/yeisondaza/30min"
  },
  %Tumentor.Mentors.Mentor{
    name: "Juan David Nicholls Cardona",
    topics: Seeds.string_to_map("Cloud,Game Development,Mobile Development,Web Development"),
    github_url: "https://github.com/jdnichollsc",
    schedule_url: "https://calendly.com/jdnichollsc"
  },
  %Tumentor.Mentors.Mentor{
    name: "Fabián Velosa",
    topics: Seeds.string_to_map("101,JavaScript,Linux"),
    github_url: "https://github.com/egxn",
    schedule_url: "https://calendly.com/egxn"
  },
  %Tumentor.Mentors.Mentor{
    name: "Cristian David Ippolito",
    topics: Seeds.string_to_map("Backend Development,JavaScript,Web Development"),
    github_url: "https://github.com/Cristiandi",
    schedule_url: "https://calendly.com/cristiandi"
  },
  %Tumentor.Mentors.Mentor{
    name: "Simon Soriano",
    topics:
      Seeds.string_to_map("Resume,entrevistas,entrevistas no técnicas,negociación de salario"),
    github_url: "https://github.com/simon0191",
    schedule_url: "https://calendly.com/simonsoriano"
  },
  %Tumentor.Mentors.Mentor{
    name: "Álvaro José Agámez Licha",
    topics:
      Seeds.string_to_map(
        "Backend Development,Game Development,JavaScript,Node.js,Resume,entrevistas,negociación de salario"
      ),
    github_url: "https://github.com/aagamezl",
    schedule_url: "https://calendly.com/alvaroagamezlicha"
  },
  %Tumentor.Mentors.Mentor{
    name: "Leonardo Ardila Osorio",
    topics:
      Seeds.string_to_map(
        "JavaScript,Resume,Web Development,entrevistas,entrevistas no técnicas,negociación de salario"
      ),
    github_url: "https://github.com/LeoDiBlack",
    schedule_url: "https://calendly.com/leodiblack"
  },
  %Tumentor.Mentors.Mentor{
    name: "Diego Adrada",
    topics:
      Seeds.string_to_map(
        "Cómo empezar en videojuegos,Desarrollo de videojuegos,Marketing de videojuegos"
      ),
    schedule_url: "https://calendly.com/adrada"
  },
  %Tumentor.Mentors.Mentor{
    name: "Santiago Bernal",
    topics:
      Seeds.string_to_map("Backend Development,Database Design,Desarrollo web,Linux,Security"),
    github_url: "https://github.com/santiagu",
    schedule_url: "https://calendly.com/adrada"
  },
  %Tumentor.Mentors.Mentor{
    name: "Mauricio Mantilla",
    topics: Seeds.string_to_map("CSS,Desarrollo web,Frontend Development"),
    github_url: "https://github.com/Mantish",
    schedule_url: "https://calendly.com/mantish"
  },
  %Tumentor.Mentors.Mentor{
    name: "Rolando Avila",
    topics: Seeds.string_to_map("Mobile Development"),
    github_url: "https://github.com/erolando",
    schedule_url: "https://calendly.com/erolando"
  },
  %Tumentor.Mentors.Mentor{
    name: "Oscar Rendon",
    topics:
      Seeds.string_to_map(
        "Backend Development,Database Design,Resume,entrevistas,entrevistas no técnicas"
      ),
    github_url: "https://github.com/orendon",
    schedule_url: "https://calendly.com/el0sky/"
  },
  %Tumentor.Mentors.Mentor{
    name: "Joan Serna",
    topics:
      Seeds.string_to_map("CSS,Desarrollo web,Frontend Development,JavaScript,Web Development"),
    github_url: "https://github.com/JoanSerna",
    schedule_url: "https://calendly.com/joanserna"
  },
  %Tumentor.Mentors.Mentor{
    name: "Fredy E",
    topics: Seeds.string_to_map("Desarrollo de videojuegos,Metodología de Aprendizaje,Programación en C,Unreal Engine"),
    github_url: "https://github.com/xfry",
    schedule_url: "xfry @ hackdo.org"
  }
]

Enum.each(initial_mentors, fn mentor ->
  Repo.insert!(mentor)
end)
