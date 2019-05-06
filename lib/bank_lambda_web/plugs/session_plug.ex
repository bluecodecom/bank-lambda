defmodule BankLambdaWeb.SessionPlug do
  import Plug.Conn
  alias BankLambda.Accounts

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_session(conn, :current_user_id) do
      nil ->
        conn

      current_user_id ->
        current_user = Accounts.get_user!(current_user_id)
        assign(conn, :current_user, current_user)
    end
  end
end
