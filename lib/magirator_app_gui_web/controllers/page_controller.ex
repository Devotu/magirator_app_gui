defmodule MagiratorAppGuiWeb.PageController do
  use MagiratorAppGuiWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
