defmodule BeebookWeb.NavLive do
  use Phoenix.LiveView

  alias BeebookWeb.NavView

  def mount(_session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    NavView.render("nav.html", assigns)
  end
end
