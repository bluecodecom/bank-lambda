defmodule BankLambdaWeb.RedirectPlug do
  import Plug.Conn
  alias BankLambda.Accounts.User
  alias BankLambdaWeb.Router.Helpers, as: Routes

  def init(opts), do: opts

  def call(%{assigns: %{current_user: %User{}}} = conn, _opts), do: conn

  def call(
        %{params: %{"client_id" => _, "redirect_uri" => _, "response_type" => _}} = conn,
        _opts
      ) do
    conn = halt(conn)
    Phoenix.Controller.redirect(conn, to: Routes.session_path(conn, :new, conn.params))
  end

  def call(conn, _opts), do: conn
end
