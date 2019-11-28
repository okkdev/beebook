defmodule Beebook.AccountsTest do
  use Beebook.DataCase

  alias Beebook.Accounts

  describe "users" do
    alias Beebook.Accounts.User

    @valid_attrs %{email: "some email", password: "some password"}
    @update_attrs %{email: "some updated email", password: "some updated password"}
    @invalid_attrs %{email: nil, password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.password == "some password"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.password == "some updated password"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "roles" do
    alias Beebook.Accounts.Role

    @valid_attrs %{name: "some name", role: "some role"}
    @update_attrs %{name: "some updated name", role: "some updated role"}
    @invalid_attrs %{name: nil, role: nil}

    def role_fixture(attrs \\ %{}) do
      {:ok, role} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_role()

      role
    end

    test "list_roles/0 returns all roles" do
      role = role_fixture()
      assert Accounts.list_roles() == [role]
    end

    test "get_role!/1 returns the role with given id" do
      role = role_fixture()
      assert Accounts.get_role!(role.id) == role
    end

    test "create_role/1 with valid data creates a role" do
      assert {:ok, %Role{} = role} = Accounts.create_role(@valid_attrs)
      assert role.name == "some name"
      assert role.role == "some role"
    end

    test "create_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_role(@invalid_attrs)
    end

    test "update_role/2 with valid data updates the role" do
      role = role_fixture()
      assert {:ok, %Role{} = role} = Accounts.update_role(role, @update_attrs)
      assert role.name == "some updated name"
      assert role.role == "some updated role"
    end

    test "update_role/2 with invalid data returns error changeset" do
      role = role_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_role(role, @invalid_attrs)
      assert role == Accounts.get_role!(role.id)
    end

    test "delete_role/1 deletes the role" do
      role = role_fixture()
      assert {:ok, %Role{}} = Accounts.delete_role(role)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_role!(role.id) end
    end

    test "change_role/1 returns a role changeset" do
      role = role_fixture()
      assert %Ecto.Changeset{} = Accounts.change_role(role)
    end
  end
end
