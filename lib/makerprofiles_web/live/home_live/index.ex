defmodule MakerprofilesWeb.HomeLive.Index do
  use MakerprofilesWeb, :live_view

  on_mount {MakerprofilesWeb.UserAuth, :mount_current_user}

  import Ecto.Query, warn: false

  alias Makerprofiles.Maker
  alias Makerprofiles.Maker.Skill

  @impl true
  def mount(_params, _session, socket) do
    skills_query = from s in Skill, order_by: [{:asc, :name}], limit: 3
    latest_profiles = Maker.list_profiles(limit: 4, sort: %{sort_by: :updated_at, sort_order: :desc}, preload: [skills: skills_query])

    socket =
      socket
      |> assign(latest_profiles: latest_profiles)

    {:ok, socket}
  end
end
