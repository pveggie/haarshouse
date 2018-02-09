class AddUserToTune < ActiveRecord::Migration
  def change
    add_reference :tunes, :user, foreign_key: true
  end
end
