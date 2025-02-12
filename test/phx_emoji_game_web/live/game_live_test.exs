defmodule PhxEmojiGameWeb.GameLiveTest do
  use PhxEmojiGameWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhxEmojiGame.Emoji

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp fixture(:game) do
    {:ok, game} = Emoji.create_game(@create_attrs)
    game
  end

  defp create_game(_) do
    game = fixture(:game)
    %{game: game}
  end

  describe "Index" do
    setup [:create_game]

    test "lists all games", %{conn: conn, game: game} do
      {:ok, _index_live, html} = live(conn, Routes.game_index_path(conn, :index))

      assert html =~ "Listing Games"
    end

    test "saves new game", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.game_index_path(conn, :index))

      assert index_live |> element("a", "New Game") |> render_click() =~
               "New Game"

      assert_patch(index_live, Routes.game_index_path(conn, :new))

      assert index_live
             |> form("#game-form", game: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#game-form", game: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.game_index_path(conn, :index))

      assert html =~ "Game created successfully"
    end

    test "updates game in listing", %{conn: conn, game: game} do
      {:ok, index_live, _html} = live(conn, Routes.game_index_path(conn, :index))

      assert index_live |> element("#game-#{game.id} a", "Edit") |> render_click() =~
               "Edit Game"

      assert_patch(index_live, Routes.game_index_path(conn, :edit, game))

      assert index_live
             |> form("#game-form", game: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#game-form", game: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.game_index_path(conn, :index))

      assert html =~ "Game updated successfully"
    end

    test "deletes game in listing", %{conn: conn, game: game} do
      {:ok, index_live, _html} = live(conn, Routes.game_index_path(conn, :index))

      assert index_live |> element("#game-#{game.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#game-#{game.id}")
    end
  end

  describe "Show" do
    setup [:create_game]

    test "displays game", %{conn: conn, game: game} do
      {:ok, _show_live, html} = live(conn, Routes.game_show_path(conn, :show, game))

      assert html =~ "Show Game"
    end

    test "updates game within modal", %{conn: conn, game: game} do
      {:ok, show_live, _html} = live(conn, Routes.game_show_path(conn, :show, game))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Game"

      assert_patch(show_live, Routes.game_show_path(conn, :edit, game))

      assert show_live
             |> form("#game-form", game: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#game-form", game: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.game_show_path(conn, :show, game))

      assert html =~ "Game updated successfully"
    end
  end
end
