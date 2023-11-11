class CreateTunes < ActiveRecord::Migration[4.2]
  def change
    create_table :tunes do |t|
      t.string :poster
      t.string :youtube_video_id
      t.string :game_title
      t.string :song_title
      t.text :poster_comment
      t.integer :views, default: 0

      t.timestamps null: false
    end
  end
end
