defmodule MakerprofilesWeb.PageController do
  use MakerprofilesWeb, :controller

  def about(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :about)
  end
end
