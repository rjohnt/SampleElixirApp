defmodule HelloWeb.Router do
  use HelloWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    forward "/jobs", BackgroundJob.Plug
  end

  scope "/", HelloWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show

    resources "/users", UserController do
      resources "/posts", PostController
    end

    resources "/comments", CommentsController, except: [:delete]
    resources "/reviews", ReviewController
  end

  scope "/admin", HelloWeb.Admin, as: :admin do
    pipe_through :browser

    resources "/images", ImageController
    resources "/reviews", ReviewController
    resources "/users", UserController
  end

  scope "/api", HelloWeb do
    pipe_through :api

    resources "/reviews", ReviewController
  end

  # Other scopes may use custom stacks.
  # scope "/api", HelloWeb do
  #   pipe_through :api
  # end
end
