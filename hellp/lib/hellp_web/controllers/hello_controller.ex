defmodule HellpWeb.HelloController do
  use HellpWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end

  def show(conn, %{"messenger" => messenger}) do
    render(conn, :show, messenger: messenger)
  end
end
