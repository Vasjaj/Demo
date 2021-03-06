defmodule DemoWeb.Router do
  use DemoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug DemoWeb.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DemoWeb do
    pipe_through [:browser]

    get "/", PostController, :index

    scope "/posts" do
      resources "/", PostController
    end

    scope "/auth" do
      get "/sign_out",           AuthController, :sign_out
      get "/:provider",          AuthController, :request
      get "/:provider/callback", AuthController, :callback
    end
  end

  scope "/api", DemoWeb do
    pipe_through :api

    get "/fib/:number" , FibController, :fib
  end
end
