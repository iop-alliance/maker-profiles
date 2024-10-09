defmodule MakerprofilesWeb.SkillLive.FormComponent do
  use MakerprofilesWeb, :live_component

  alias Makerprofiles.Maker

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage skill records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="skill-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Skill</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{skill: skill} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Maker.change_skill(skill))
     end)}
  end

  @impl true
  def handle_event("validate", %{"skill" => skill_params}, socket) do
    changeset = Maker.change_skill(socket.assigns.skill, skill_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"skill" => skill_params}, socket) do
    save_skill(socket, socket.assigns.action, skill_params)
  end

  defp save_skill(socket, :edit, skill_params) do
    case Maker.update_skill(socket.assigns.skill, skill_params) do
      {:ok, skill} ->
        notify_parent({:saved, skill})

        {:noreply,
         socket
         |> put_flash(:info, "Skill updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_skill(socket, :new, skill_params) do
    case Maker.create_skill(skill_params) do
      {:ok, skill} ->
        notify_parent({:saved, skill})

        {:noreply,
         socket
         |> put_flash(:info, "Skill created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
