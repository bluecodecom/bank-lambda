defmodule BankLambdaWeb.Router do
  use BankLambdaWeb, :router
  use PhoenixOauth2Provider.Router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :api_auth do
    plug(ExOauth2Provider.Plug.VerifyHeader, realm: "Bearer")
    plug(ExOauth2Provider.Plug.EnsureAuthenticated)
  end

  pipeline :protected do
    plug(BankLambdaWeb.RedirectPlug)
  end

  pipeline :user do
    plug(BankLambdaWeb.SessionPlug)
  end

  pipeline :oauth_public do
    plug(:put_secure_browser_headers)
  end

  scope "/" do
    pipe_through(:oauth_public)
    oauth_routes(:public)
  end

  scope "/" do
    pipe_through(:browser)
    pipe_through(:user)
    pipe_through(:protected)
    oauth_routes(:protected)
  end

  scope "/", BankLambdaWeb do
    pipe_through(:browser)
    pipe_through(:user)

    get("/", DashboardController, :index)
  end

  scope "/auth", BankLambdaWeb.Auth do
    pipe_through(:browser)
    pipe_through(:user)

    get("/login", SessionController, :new)
    post("/login", SessionController, :login)

    get("/tan", SessionController, :tan)
    post("/tan", SessionController, :confirm_tan)
  end

  scope "/api/v1", BankLambdaWeb.Api.V1 do
    pipe_through(:api)
    pipe_through(:api_auth)

    get("/demo", DemoController, :index)

    scope "/payments" do
      post("/instant-sepa-credit-transfers", PaymentController, :payment)
    end
  end
end
