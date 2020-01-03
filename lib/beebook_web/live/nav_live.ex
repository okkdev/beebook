defmodule BeebookWeb.NavLive do
  use Phoenix.LiveView

  alias BeebookWeb.NavView

  def mount(session, socket) do
    {:ok,
     assign(socket,
       account_button: false,
       user: session["current_user"]
     )}
  end

  def render(assigns) do
    NavView.render("nav.html", assigns)
  end

  @doc """
  Handle account button toggle.
  """
  def handle_event("toggle", _, socket) do
    {:noreply, assign(socket, account_button: !socket.assigns.account_button)}
  end
end
