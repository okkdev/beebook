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
    users = Enum.sort_by(Accounts.list_users(), fn user -> user.id end)
    links = Library.list_links()
    render(conn, "index.html", users: users, links: links)
  end

  @doc """
  Updates the user admin.
  """
  def update(conn, %{"user" => user}) do
    case Accounts.update_admin(user["id"], user["admin"]) do
      {1, _} ->
        conn
        |> redirect(to: Routes.dash_path(conn, :index))

      {_, _} ->
        conn
        |> put_flash(:error, "Something went wrong...")
        |> redirect(to: Routes.dash_path(conn, :index))
    end
  end
end
