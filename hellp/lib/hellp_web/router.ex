defmodule HellpWeb.Router do
  use HellpWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {HellpWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug HellpWeb.Plugs.Locale, "en"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HellpWeb do
    pipe_through :browser

    get "/", PageController, :home
    resources "/users", UserController
    resources "/posts", PostsController, only: [:index, :show]
    resources "/comments", CommentsController, except: [:delete]
    get "/hello", HelloController, :home
    get "/hello/:messenger", HelloController, :show

    resources "/reviews", ReviewController
  end

  scope "/admin", HellpWeb.Admin do
    pipe_through :browser

    resources "/reviews", ReviewController
  end

  scope "/api", HelloWeb.Api, as: :api do
    pipe_through :api

    scope "/v1", V1, as: :v1 do
      resources "/images",  ImageController
      resources "/reviews", ReviewController
      resources "/users",   UserController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", HellpWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:hellp, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: HellpWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
