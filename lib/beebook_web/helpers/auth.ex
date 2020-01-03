defmodule BeebookWeb.Helpers.Auth do
  import Plug.Conn, only: [get_session: 2]

  def signed_in?(conn) do
    !!get_session(conn, :current_user)
  end
end
