defmodule BeebookWeb.SessionController do
  use BeebookWeb, :controller

  alias Beebook.Accounts
  alias Accounts.User

  def sign_in(conn, _params) do
    # If user is logged in and tries to connecto to "/sign-in" redirect him
    if is_logged_in?(conn) do
      redirect(conn, to: Routes.page_path(conn, :index))
    else
      render(conn, "signin.html")
    end
  end

  def sign_up(conn, _params) do
    # If user is logged in and tries to connecto to "/sign-up" redirect him
    if is_logged_in?(conn) do
      redirect(conn, to: Routes.user_path(conn, :show))
    else
      changeset = Accounts.change_user(%User{})
      render(conn, "signup.html", changeset: changeset)
    end
  end

  defp is_logged_in?(conn), do: !!get_session(conn, :current_user_id)

  @doc """
  Logs a user in
  """
  def create_session(conn, %{"session" => auth_params} = _params) do
    user = Accounts.get_by_email(auth_params["email"])

    case Pbkdf2.check_pass(user, auth_params["password_hash"]) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_flash(:info, "Sign in, successful!")
        |> redirect(to: Routes.user_path(conn, :show))

      {:error, _} ->
        conn
        |> put_flash(:error, "Invalid email or password. Please try again.")
        |> redirect(to: Routes.session_path(conn, :sign_in))
    end
  end

  @doc """
  Creates a new user
  """
  def create_user(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_flash(:info, "Sign up, successful!")
        |> redirect(to: Routes.user_path(conn, :show))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "signup.html", changeset: changeset)
    end
  end

  @doc """
  Deletes a user session
  """
  def sign_out(conn, _params) do
    conn
    |> delete_session(:current_user_id)
    |> put_flash(:info, "Signed out.")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
