defmodule BeebookWeb.DashController do
  use BeebookWeb, :controller

  alias Beebook.Library
  alias Beebook.Accounts

  plug :check_auth

  defp check_auth(conn, _args) do
    if conn.assigns.current_user.admin do
      conn
    else
      conn
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

  def index(conn, _params) do
    users = Accounts.list_users()
    links = Library.list_links()
    render(conn, "index.html", users: users, links: links)
  end
end
