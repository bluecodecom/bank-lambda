defmodule BankLambdaWeb.Api.V1.PaymentController do
  use BankLambdaWeb, :controller

  def create(conn, params) do
    json(conn, %{status: :ok})
  end
end
