defmodule BeebookWeb.LibraryLive do
  use Phoenix.LiveView

  alias Beebook.Library
  alias BeebookWeb.LibraryView

  def mount(session, socket) do
    Library.subscribe()

    {:ok, fetch(assign(socket, :current_user_id, session["current_user_id"]))}
  end

  def render(assigns) do
    LibraryView.render("index.html", assigns)
  end

  def handle_event("add", %{"link" => link}, socket) do
    link
    |> Map.put("user_id", socket.assigns[:current_user_id])
    |> Library.create_link()

    {:noreply, socket}
  end

  def handle_info({Library, [:link | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  defp fetch(socket) do
    assign(socket, links: Library.list_links(socket.assigns[:current_user_id]))
  end
end
