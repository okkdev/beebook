defmodule BeebookWeb.DashController do
  use BeebookWeb, :controller

  alias Beebook.Library
  alias Beebook.Accounts

  def index(conn, _params) do
    users = Accounts.list_users()
    links = Library.list_links()
    render(conn, "index.html", users: users, links: links)
  end
end
