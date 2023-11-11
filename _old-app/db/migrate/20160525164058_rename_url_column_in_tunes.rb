class RenameUrlColumnInTunes < ActiveRecord::Migration[4.2]
  def change
    rename_column :tunes, :url, :youtube_video_id
  end
end
