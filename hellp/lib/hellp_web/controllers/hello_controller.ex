defmodule HellpWeb.HelloController do
  use HellpWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
