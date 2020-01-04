defmodule BeebookWeb.Helpers.AuthPlug do
  import Plug.Conn
  import Phoenix.Controller
  alias Beebook.Accounts

  def init(default), do: default

  def call(conn, _opts) do
    user = get_session(conn, :current_user)
    auth_reply(conn, user)
  end

  defp auth_reply(conn, nil) do
    conn
    |> put_flash(:error, "You have to sign in first!")
    |> redirect(to: "/signin")
    |> halt()
  end

  defp auth_reply(conn, user) do
    conn
    |> assign(:current_user, user)
  end
end
