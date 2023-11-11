class AddViewsToTunes < ActiveRecord::Migration[4.2]
  def change
    add_column :tunes, :views, :integer, default: 0
  end
end
