defmodule Beebook.Library do
  @moduledoc """
  The Library context.
  """

  import Ecto.Query, warn: false
  alias Beebook.Repo

  alias Beebook.Library.Links

  @doc """
  Returns the list of link.

  ## Examples

      iex> list_link()
      [%Links{}, ...]

  """
  def list_link do
    Repo.all(Links)
  end

  @doc """
  Gets a single links.

  Raises `Ecto.NoResultsError` if the Links does not exist.

  ## Examples

      iex> get_links!(123)
      %Links{}

      iex> get_links!(456)
      ** (Ecto.NoResultsError)

  """
  def get_links!(id), do: Repo.get!(Links, id)

  @doc """
  Creates a links.

  ## Examples

      iex> create_links(%{field: value})
      {:ok, %Links{}}

      iex> create_links(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_links(attrs \\ %{}) do
    %Links{}
    |> Links.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a links.

  ## Examples

      iex> update_links(links, %{field: new_value})
      {:ok, %Links{}}

      iex> update_links(links, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_links(%Links{} = links, attrs) do
    links
    |> Links.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Links.

  ## Examples

      iex> delete_links(links)
      {:ok, %Links{}}

      iex> delete_links(links)
      {:error, %Ecto.Changeset{}}

  """
  def delete_links(%Links{} = links) do
    Repo.delete(links)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking links changes.

  ## Examples

      iex> change_links(links)
      %Ecto.Changeset{source: %Links{}}

  """
  def change_links(%Links{} = links) do
    Links.changeset(links, %{})
  end
end
