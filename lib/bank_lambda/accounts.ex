defmodule BankLambda.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias BankLambda.Repo
  alias Comeonin.Bcrypt
  alias BankLambda.Accounts.User

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def authenticate_user(email, plain_text_password) do
    query = from u in User, where: u.email == ^email

    case Repo.one(query) do
      nil ->
        Bcrypt.dummy_checkpw()
        {:error, "Invalid credentials"}

      user ->
        if Bcrypt.checkpw(plain_text_password, user.password) do
          {:ok, user}
        else
          {:error, "Invalid credentials"}
        end
    end
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end
