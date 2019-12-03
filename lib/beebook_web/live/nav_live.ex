defmodule Beebook.NavLive do
  use Phoenix.LiveView

  alias BeebookWeb.NavView

  def render(_assigns) do
    NavView.render("nav.html")
  end

  def mount(_session, socket) do
    {:ok, socket}
  end
end
