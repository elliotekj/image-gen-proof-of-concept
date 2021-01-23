defmodule ImageGenPocWeb.PageController do
  use ImageGenPocWeb, :controller
  require Logger

  def index(conn, %{"q" => quotes, "a" => attributions}) do
    random_index = Enum.random(0..(length(quotes) - 1))
    quote = Enum.at(quotes, random_index)
    attribution = Enum.at(attributions, random_index)

    {output, 0} =
      System.cmd("convert", [
        "-background",
        "#333333",
        "-fill",
        "white",
        "-font",
        "Helvetica",
        "-pointsize",
        "56",
        "label:#{quote}",
        "-fill",
        "grey",
        "-font",
        "Helvetica-Oblique",
        "-pointsize",
        "32",
        "label:- #{attribution}",
        "-append",
        "-background",
        "#333333",
        "-gravity",
        "center",
        "-extent",
        "800x400",
        "png:-"
      ])

    conn
    |> put_resp_content_type("image/png")
    |> send_resp(200, output)
  end
end
