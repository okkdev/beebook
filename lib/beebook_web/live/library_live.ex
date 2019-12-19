defmodule BeebookWeb.LibraryLive do
  use Phoenix.LiveView

  alias Beebook.Library
  alias BeebookWeb.LibraryView

  def mount(session, socket) do
    # subscribe to user pubsub
    BeebookWeb.Endpoint.subscribe(topic(session["current_user_id"]))

    {:ok,
     fetch(
       assign(socket, current_user_id: session["current_user_id"], link: Library.change_link())
     )}
  end

  def render(assigns) do
    LibraryView.render("index.html", assigns)
  end

  @doc """
  Handle add event when adding new links.
  """
  def handle_event("add", %{"link" => link}, socket) do
    case Library.create_link(link) do
      {:ok, result} ->
        # broadcast change to other sessions from user
        BeebookWeb.Endpoint.broadcast_from(
          self(),
          topic(socket.assigns.current_user_id),
          "add",
          result
        )

        {:noreply, fetch(socket)}

      {:error, _} ->
        nil
        # put_flash(:error, "Something went wrong. Please try again.")
    end
  end

  @doc """
  Handle sort_by params.
  """
  def handle_params(%{"sort_by" => sort_by}, _uri, socket) do
    case sort_by do
      sort_by
      when sort_by in ~w(name created priority url) ->
        {:noreply, assign(socket, links: sort_links(socket.assigns.links, sort_by))}

      _ ->
        {:noreply, socket}
    end
  end

  @doc """
  Catch all for requests with no parameter.
  """
  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  @doc """
  Handle info that gets triggered by PubSub broadcasts and fetches the changes.
  """
  def handle_info(%{event: "add"}, socket) do
    {:noreply, fetch(socket)}
  end

  # Pattern matching sort functions
  defp sort_links(links, "name") do
    Enum.sort_by(links, fn links -> links.name end)
  end

  defp sort_links(links, "created") do
    Enum.sort_by(links, fn links -> links.inserted_at end, &Timex.before?/2)
  end

  defp sort_links(links, "priority") do
    Enum.sort_by(links, fn links -> links.priority end)
  end

  defp sort_links(links, "url") do
    Enum.sort_by(links, fn links -> links.url end)
  end

  # Assign helper function
  defp fetch(socket) do
    assign(socket, links: Library.list_links(socket.assigns.current_user_id))
  end

  # Topic helper for binary
  defp topic(id), do: "user:#{id}"
end
