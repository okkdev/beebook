defmodule Beebook.LibraryTest do
  use Beebook.DataCase

  alias Beebook.Library

  describe "links" do
    alias Beebook.Library.Link

    @valid_attrs %{name: "some name", priority: 42, url: "some url"}
    @update_attrs %{name: "some updated name", priority: 43, url: "some updated url"}
    @invalid_attrs %{name: nil, priority: nil, url: nil}

    def link_fixture(attrs \\ %{}) do
      {:ok, link} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Library.create_link()

      link
    end

    test "list_links/0 returns all links" do
      link = link_fixture()
      assert Library.list_links() == [link]
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert Library.get_link!(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      assert {:ok, %Link{} = link} = Library.create_link(@valid_attrs)
      assert link.name == "some name"
      assert link.priority == 42
      assert link.url == "some url"
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Library.create_link(@invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      link = link_fixture()
      assert {:ok, %Link{} = link} = Library.update_link(link, @update_attrs)
      assert link.name == "some updated name"
      assert link.priority == 43
      assert link.url == "some updated url"
    end

    test "update_link/2 with invalid data returns error changeset" do
      link = link_fixture()
      assert {:error, %Ecto.Changeset{}} = Library.update_link(link, @invalid_attrs)
      assert link == Library.get_link!(link.id)
    end

    test "delete_link/1 deletes the link" do
      link = link_fixture()
      assert {:ok, %Link{}} = Library.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> Library.get_link!(link.id) end
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = Library.change_link(link)
    end
  end
end
