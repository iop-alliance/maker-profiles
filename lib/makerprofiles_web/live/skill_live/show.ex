defmodule MakerprofilesWeb.SkillLive.Show do
  use MakerprofilesWeb, :live_view

  alias Makerprofiles.Maker

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:skill, Maker.get_skill!(id))}
  end

  defp page_title(:show), do: "Show Skill"
  defp page_title(:edit), do: "Edit Skill"
end
