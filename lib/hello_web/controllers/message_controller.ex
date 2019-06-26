defmodule HelloWeb.MessageController do
  use HelloWeb, :controller

  plug :put_headers, %{content_encoding: "gzip", cache_control: "max-age=3600"}
  plug :put_layout, "bare.html"

  def put_headers(conn, key_values) do
    Enum.reduce key_values, conn, fn {k, v}, conn ->
      Plug.Conn.put_resp_header(conn, to_string(k), v)
    end
  end
end
