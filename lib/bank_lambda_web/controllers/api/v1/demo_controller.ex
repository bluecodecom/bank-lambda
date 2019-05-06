defmodule BankLambdaWeb.Api.V1.DemoController do
  @moduledoc "This controller is just for testing the OAUTH, should be delted after"
  use BankLambdaWeb, :controller

  def index(conn, _params) do
    user = ExOauth2Provider.Plug.current_resource_owner(conn)
    IO.inspect(user, label: "USER_____")
    json(conn, %{super: :secret})
  end
end
