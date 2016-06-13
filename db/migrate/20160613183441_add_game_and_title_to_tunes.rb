class AddGameAndTitleToTunes < ActiveRecord::Migration
  def change
    add_column :tunes, :game_title, :string
    add_column :tunes, :song_title, :string
  end
end
