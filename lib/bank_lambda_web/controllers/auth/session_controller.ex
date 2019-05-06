defmodule BankLambdaWeb.Auth.SessionController do
  use BankLambdaWeb, :controller
  alias BankLambda.Accounts
  alias BankLambda.Accounts.User

  plug :already_logged_in when action in [:new, :login]

  def new(conn, params) do
    user_changeset = Accounts.change_user(%User{})

    conn
    |> put_view(BankLambdaWeb.Auth.SessionView)
    |> render("new.html", changeset: user_changeset, params: params)
  end

  def login(conn, %{"user" => %{"email" => email, "password" => password}} = params) do
    case Accounts.authenticate_user(email, password) do
      {:ok, %User{} = user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_flash(:success, "Welcome back!")
        |> redirect_after_login(params)

      {:error, reason} ->
        conn
        |> put_flash(:error, to_string(reason))
        |> new(%{})
    end
  end

  defp redirect_after_login(conn, %{
         "client_id" => client_id,
         "redirect_uri" => redirect_uri,
         "response_type" => response_type
       }) do
    params = %{client_id: client_id, redirect_uri: redirect_uri, response_type: response_type}
    redirect(conn, to: Routes.oauth_authorization_path(conn, :new, params))
  end

  defp redirect_after_login(conn, _params) do
    redirect(conn, to: "/")
  end

  defp already_logged_in(%{assigns: %{current_user: %User{}}} = conn, _opts) do
    conn
    |> put_flash(:success, "Welcome back!")
    |> redirect(to: "/")
    |> halt()
  end

  defp already_logged_in(conn, _opts), do: conn
end
