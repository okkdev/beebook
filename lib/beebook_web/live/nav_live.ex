defmodule LiveViewBeebook.NavLive do
  use Phoenix.LiveView

  alias BeebookWeb.Nav

  def render(assigns) do
  end

  def mount(_session, socket) do
    {:ok, socket}
  end
end
