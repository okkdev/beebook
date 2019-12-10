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

  scope "/", BeebookWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/register", UserController
    # resources "/library", LibraryController, :index
    get "/dashboard", DashController, :index
    get "/library", LibraryController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", BeebookWeb do
  #   pipe_through :api
  # end
end
