class AddGameAndTitleToTunes < ActiveRecord::Migration[4.2]
  def change
    add_column :tunes, :game_title, :string
    add_column :tunes, :song_title, :string
  end
end
