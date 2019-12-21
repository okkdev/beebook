defmodule BeebookWeb.LibraryLive do
  use Phoenix.LiveView

  alias Beebook.Library
  alias Beebook.Library.Link
  alias BeebookWeb.LibraryView

  def mount(session, socket) do
    # subscribe to user pubsub
    BeebookWeb.Endpoint.subscribe(topic(session["current_user_id"]))

    {:ok,
     fetch(
       assign(socket,
         current_user_id: session["current_user_id"],
         link_changeset: Library.change_link(%Link{}),
         sort_by: "created",
         query: ""
       )
     )}
  end

  def render(assigns) do
    LibraryView.render("index.html", assigns)
  end

  @doc """
  Handle Search.
  """
  def handle_event("search", %{"q" => query}, socket) when byte_size(query) <= 100 do
    {:noreply, search_links(query, socket)}
  end

  @doc """
  Deletes links by ID
  """
  def handle_event("delete", %{"link" => %{"id" => id}}, socket) do
    # find link by id
    link = Enum.find(socket.assigns.search, &(&1.id == String.to_integer(id)))

    case Library.delete_link(link) do
      {:ok, _} ->
        # broadcast change to other sessions from user
        BeebookWeb.Endpoint.broadcast_from(
          self(),
          topic(socket.assigns.current_user_id),
          "delete",
          link
        )

        {:noreply, fetch(socket)}

      {:error, _} ->
        {:noreply, socket}
    end
  end

  @doc """
  Handle add event when adding new links.
  """
  def handle_event("add", %{"link" => link}, socket) do
    case Library.create_link(link) do
      {:ok, link} ->
        # broadcast change to other sessions from user
        BeebookWeb.Endpoint.broadcast_from(
          self(),
          topic(socket.assigns.current_user_id),
          "add",
          link
        )

        {:noreply, add_link(link, socket)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, link_changeset: changeset)}
    end
  end

  @doc """
  Handle info that gets triggered by PubSub broadcasts and adds the new link to the available links.
  """
  def handle_info(%{event: "add", payload: link}, socket) do
    {:noreply, add_link(link, socket)}
  end

  @doc """
  Handle info that gets triggered by PubSub broadcasts and fetches the changes.
  """
  def handle_info(%{event: "delete"}, socket) do
    {:noreply, fetch(socket)}
  end

  @doc """
  Handle sort_by params.
  """
  def handle_params(%{"sort_by" => sort_by}, _uri, socket) do
    case sort_by do
      sort_by
      when sort_by in ~w(name created priority url priority_medium priority_low) ->
        links = sort_links(socket.assigns.search, sort_by)

        {:noreply, search_links(assign(socket, links: links, search: links, sort_by: sort_by))}

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

  defp sort_links(links, "priority_medium") do
    sort_links_priority(links, 2)
  end

  defp sort_links(links, "priority_low") do
    sort_links_priority(links, 3)
  end

  defp sort_links(links, "url") do
    Enum.sort_by(links, fn links -> links.url end)
  end

  # Sort specific priority to the top
  defp sort_links_priority(links, prio) do
    rest =
      links
      |> Enum.filter(fn x -> x.priority != prio end)
      |> Enum.sort_by(fn links -> links.priority end)

    Enum.filter(links, fn x -> x.priority == prio end) ++ rest
  end

  # Assign helper function
  defp fetch(socket) do
    links = sort_links(Library.list_links(socket.assigns.current_user_id), socket.assigns.sort_by)
    search_links(assign(socket, links: links, search: links))
  end

  # Adds a new link to the list and updates the search list
  defp add_link(link, socket) do
    links = sort_links([link | socket.assigns.search], socket.assigns.sort_by)
    search_links(assign(socket, links: links, search: links))
  end

  defp search_links(socket) do
    search_links(socket.assigns.query, socket)
  end

  # Searches through the search list of links and adds them to the links assign
  defp search_links(query, socket) do
    links =
      Enum.filter(
        socket.assigns.search,
        &String.contains?(String.downcase(&1.name), String.downcase(query))
      )

    assign(socket, query: query, links: links)
  end

  # Topic helper for binary
  defp topic(id), do: "user:#{id}"
end
