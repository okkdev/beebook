defmodule BeebookWeb.Router do
  use BeebookWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug BeebookWeb.Helpers.AuthPlug
  end

  scope "/", BeebookWeb do
    pipe_through :browser

    get "/", PageController, :index

    # Sign in
    get "/sign-in", SessionController, :sign_in
    post "/sign-in", SessionController, :create_session

    # Sign up
    get "/sign-up", SessionController, :sign_up
    post "/sign-up", SessionController, :create_user

    # Sign out
    post "/sign-out", SessionController, :sign_out
  end

  # User Scope
  scope "/", BeebookWeb do
    pipe_through [:browser, :auth]
    resources "/users", UserController, only: [:show, :edit, :update], singleton: true

    live "/library", LibraryLive

    get "/dashboard", DashController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", BeebookWeb do
  #   pipe_through :api
  # end
end
