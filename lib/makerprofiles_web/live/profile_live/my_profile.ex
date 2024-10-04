defmodule MakerprofilesWeb.ProfileLive.MyProfile do
  use MakerprofilesWeb, :live_view

  alias Makerprofiles.Maker

  @impl true
  def mount(_params, _session, socket) do
    user = socket.assigns.current_user
    profile = Maker.get_profile_by_user_id!(user.id)

    {:ok,
      socket
      |> assign(:page_title, "My Profile")
      |> assign(:user_id, user.id)
      |> assign(:profile, profile)}
  end
end
