defmodule MakerprofilesWeb.ProfileLive.ProfileFormComponent do
  use MakerprofilesWeb, :live_component

  alias Makerprofiles.Maker

  @do_space "maker-profiles"
  @do_region "fra1"
  @do_url "https://#{@do_space}.#{@do_region}.digitaloceanspaces.com"

  @impl true
  def update(%{profile: profile} = assigns, socket) do
    socket =
      allow_upload(
        socket,
        :profile_image,
        accept: ~w(.png .jpeg .jpg),
        max_file_size: 2_000_000,
        external: &presign_upload/2
      )

    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Maker.change_profile(profile))
     end)}
  end

  @impl true
  def handle_event("validate", %{"profile" => profile_params}, socket) do
    changeset = Maker.change_profile(socket.assigns.profile, profile_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"profile" => profile_params}, socket) do
    profile_image_location =
      consume_uploaded_entries(socket, :profile_image, fn _meta, entry ->
        {:ok, Path.join(@do_url, filename(entry))}
      end)

    IO.inspect(profile_image_location)
    # don't add :profile_image_location to profile_params unless an image
    # has been added to the form, otherwise :profile_image_location
    # will be replaced with NULL
    profile_params =
      case length(profile_image_location) do
        0 ->
          profile_params
        _ ->
          Map.put(profile_params, "profile_image_location", Enum.at(profile_image_location, 0))
      end

    save_profile(socket, profile_params)
  end

  defp save_profile(socket, profile_params) do
    case Maker.update_profile(socket.assigns.profile, profile_params) do
      {:ok, profile} ->
        {:noreply,
         socket
         |> put_flash(:info, "Profile updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp presign_upload(entry, socket) do
    config = %{
      region: @do_region,
      access_key_id: System.fetch_env!("SPACES_ACCESS_KEY_ID"),
      secret_access_key: System.fetch_env!("SPACES_SECRET_ACCESS_KEY")
    }

    {:ok, fields} =
      SimpleS3Upload.sign_form_upload(config, @do_space,
        key: filename(entry),
        content_type: entry.client_type,
        max_file_size: socket.assigns.uploads.profile_image.max_file_size,
        expires_in: :timer.hours(1)
      )


    metadata = %{
      uploader: "S3",
      key: filename(entry),
      url: @do_url,
      fields: fields
    }

    {:ok, metadata, socket}
  end

  defp filename(entry) do
    "profile-images/#{entry.uuid}-#{entry.client_name}"
  end
end
