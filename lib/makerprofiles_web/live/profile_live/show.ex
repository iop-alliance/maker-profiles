defmodule MakerprofilesWeb.ProfileLive.Show do
  use MakerprofilesWeb, :live_view

  alias Makerprofiles.Maker

  @impl true
  def mount(_params, _session, socket) do
    user = socket.assigns.current_user

    {:ok,
      socket
      |> assign(:user_id, user.id)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    profile = Maker.get_profile!(id)

    case socket.assigns.current_user.id == profile.user.id do
      true ->
        {:noreply, push_patch(socket, to: ~p"/profiles/me")}
      _ ->
        {:noreply,
         socket
         |> assign(:page_title, page_title(socket.assigns.live_action))
         |> assign(:profile, profile)}
    end

  end

  defp page_title(:show), do: "Show Profile"
  defp page_title(:edit), do: "Edit Profile"
end
