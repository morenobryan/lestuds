defmodule StudyManagerWeb.PageController do
  use StudyManagerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
