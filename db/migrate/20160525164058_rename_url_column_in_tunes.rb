class RenameUrlColumnInTunes < ActiveRecord::Migration
  def change
    rename_column :tunes, :url, :youtube_video_id
  end
end
