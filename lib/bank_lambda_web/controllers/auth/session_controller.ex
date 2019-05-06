defmodule BankLambdaWeb.Auth.SessionController do
  use BankLambdaWeb, :controller
  alias BankLambda.Accounts
  alias BankLambda.Accounts.User

  plug :already_logged_in when action in [:new, :login]

  def new(conn, params) do
    user_changeset = Accounts.change_user(%User{})

    conn
    |> render("new.html", changeset: user_changeset, params: params)
  end

  def login(conn, %{"user" => %{"email" => email, "password" => password}} = params) do
    case Accounts.authenticate_user(email, password) do
      {:ok, %User{} = user} ->
        oauth_params = oauth_params(params)

        conn
        |> put_session(:current_user_id, user.id)
        |> redirect(to: Routes.session_path(conn, :tan, oauth_params))

      {:error, reason} ->
        conn
        |> put_flash(:error, to_string(reason))
        |> new(%{})
    end
  end

  def tan(conn, params) do
    user_changeset = Accounts.change_user(%User{})

    conn
    |> render("tan.html", changeset: user_changeset, params: params)
  end

  def confirm_tan(conn, params) do
    # For demo purpose, all tans will be valid

    oauth_params = oauth_params(params)

    conn
    |> put_flash(:success, "Welcome back!")
    |> redirect_after_login(oauth_params)
  end

  defp redirect_after_login(
         conn,
         %{
           client_id: _client_id,
           redirect_uri: _redirect_uri,
           response_type: _response_type
         } = params
       ) do
    oauth_params = oauth_params(params)
    redirect(conn, to: Routes.oauth_authorization_path(conn, :new, oauth_params))
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

  def oauth_params(%{
        "client_id" => client_id,
        "redirect_uri" => redirect_uri,
        "response_type" => response_type
      }) do
    %{client_id: client_id, redirect_uri: redirect_uri, response_type: response_type}
  end

  def oauth_params(params), do: params
end
