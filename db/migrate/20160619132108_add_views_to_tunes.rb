class AddViewsToTunes < ActiveRecord::Migration
  def change
    add_column :tunes, :views, :integer, default: 0
  end
end
