defmodule PhxEmojiGameWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers

  @doc """
  Renders a component inside the `PhxEmojiGameWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, PhxEmojiGameWeb.GameLive.FormComponent,
        id: @game.id || :new,
        action: @live_action,
        game: @game,
        return_to: Routes.game_index_path(@socket, :index) %>
  """
end
