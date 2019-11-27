defmodule BeebookWeb.PageController do
  use BeebookWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
