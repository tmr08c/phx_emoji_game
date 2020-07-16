defmodule PhxEmojiGameWeb.GameLive.Index do
  use PhxEmojiGameWeb, :live_view
  use Ecto.Schema
  import Ecto.Changeset

  @external_resource "priv/challenges.json"
  @challenges "priv/challenges.json"
              |> File.read!()
              |> Jason.decode!()

  embedded_schema do
    field :guess, :string
  end

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, :emojis, new_game())
    socket =
      socket
      |> assign(:changeset, changeset(%__MODULE__{}, %{}))
      |> assign(:correct, nil)
      |> assign(:done, false)
      |> assign_challenge()

    {:ok, socket}
  end

  @impl true
  def handle_event("save", %{"index" => %{ "guess" => guess}}, socket) do
    %{"answer" => answer } = socket.assigns.challenge

    guess = guess |> String.downcase() |> String.trim()

    if guess == answer do
      Process.send_after(self(), :expire, 2000)
      {:noreply, socket |> assign_challenge() |> assign(:correct, true)}
    else
      {:noreply, assign(socket, :correct, false)}
    end
  end

  @impl true
  def handle_event("random", _, socket) do
    {:noreply, socket |> assign_challenge(false)}
  end

  @impl true
  def handle_info(:expire, socket) do
    {:noreply, assign(socket, :correct, nil)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, socket}
  end

  defp assign_challenge(socket, guess \\ true) do
    if Enum.empty?(socket.assigns.emojis) do
      assign(socket, :done, true)
    else
      [challenge | available] = Enum.shuffle(socket.assigns.emojis)
      socket = assign(socket, :challenge, challenge)
      if guess do
        socket
        |> assign(:correct, nil)
        |> assign(:emojis, available)
      else
        socket
      end
    end
  end

  defp new_game do
    Enum.shuffle(@challenges)
  end

  defp changeset(changeset, params) do
    cast(changeset, params, ~w[guess]a)
  end

  def result_text(true), do: "Yes! You got it!"
  def result_text(false), do: "You got it wrong!"
  def result_text(nil), do: ""
end
