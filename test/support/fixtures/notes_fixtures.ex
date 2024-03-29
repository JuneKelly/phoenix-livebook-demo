defmodule TinyNote.NotesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TinyNote.Notes` context.
  """

  @doc """
  Generate a note.
  """
  def note_fixture(attrs \\ %{}) do
    {:ok, note} =
      attrs
      |> Enum.into(%{
        body: "some body",
        title: "some title"
      })
      |> TinyNote.Notes.create_note()

    note
  end
end
