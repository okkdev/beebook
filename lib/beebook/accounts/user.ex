defmodule Beebook.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :admin, :boolean, default: false
    field :email, :string
    field :password_hash, :string
    # Virtual fields
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :password_confirmation, :admin])
    |> validate_required([:email, :password, :password_confirmation, :admin])
    # Check that email is valid
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8, max: 100)
    # Validate password rules
    |> validate_format(
      :password,
      ~r/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[#$^+=!*()@%&]).{8,100}$/,
      message:
        "The password needs at least 1 uppercase character, 1 lowercase character, 1 number and 1 special character"
    )
    # Check that password == password_confirmation
    |> validate_confirmation(:password)
    |> validate_length(:email, max: 100)
    |> unique_constraint(:email)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(pass))

      _ ->
        changeset
    end
  end
end
