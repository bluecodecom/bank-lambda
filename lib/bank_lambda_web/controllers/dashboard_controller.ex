defmodule BankLambdaWeb.DashboardController do
  use BankLambdaWeb, :controller

  require Ecto.Query

  alias BankLambda.Accounts.User

  plug(:log_in when action in [:index])

  def index(%{assigns: %{current_user: current_user}} = conn, _params) do
    transactions =
      BankLambda.Payments.Payment
      |> Ecto.Query.order_by(desc_nulls_last: :inserted_at)
      |> BankLambda.Repo.all()

    render(conn, "index.html", current_user: current_user, transactions: transactions)
  end

  defp log_in(%{assigns: %{current_user: %User{}}} = conn, _opts) do
    conn
  end

  defp log_in(conn, _opts) do
    conn
    |> put_flash(:success, "You need to login!")
    |> redirect(to: Routes.session_path(conn, :new))
    |> halt()
  end
end
