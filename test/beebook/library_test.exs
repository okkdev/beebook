defmodule Beebook.LibraryTest do
  use Beebook.DataCase

  alias Beebook.Library

  describe "link" do
    alias Beebook.Library.Links

    @valid_attrs %{name: "some name", priority: 42, url: "some url"}
    @update_attrs %{name: "some updated name", priority: 43, url: "some updated url"}
    @invalid_attrs %{name: nil, priority: nil, url: nil}

    def links_fixture(attrs \\ %{}) do
      {:ok, links} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Library.create_links()

      links
    end

    test "list_link/0 returns all link" do
      links = links_fixture()
      assert Library.list_link() == [links]
    end

    test "get_links!/1 returns the links with given id" do
      links = links_fixture()
      assert Library.get_links!(links.id) == links
    end

    test "create_links/1 with valid data creates a links" do
      assert {:ok, %Links{} = links} = Library.create_links(@valid_attrs)
      assert links.name == "some name"
      assert links.priority == 42
      assert links.url == "some url"
    end

    test "create_links/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Library.create_links(@invalid_attrs)
    end

    test "update_links/2 with valid data updates the links" do
      links = links_fixture()
      assert {:ok, %Links{} = links} = Library.update_links(links, @update_attrs)
      assert links.name == "some updated name"
      assert links.priority == 43
      assert links.url == "some updated url"
    end

    test "update_links/2 with invalid data returns error changeset" do
      links = links_fixture()
      assert {:error, %Ecto.Changeset{}} = Library.update_links(links, @invalid_attrs)
      assert links == Library.get_links!(links.id)
    end

    test "delete_links/1 deletes the links" do
      links = links_fixture()
      assert {:ok, %Links{}} = Library.delete_links(links)
      assert_raise Ecto.NoResultsError, fn -> Library.get_links!(links.id) end
    end

    test "change_links/1 returns a links changeset" do
      links = links_fixture()
      assert %Ecto.Changeset{} = Library.change_links(links)
    end
  end
end
