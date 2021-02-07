class AddUserToTune < ActiveRecord::Migration[4.2]
  def change
    add_reference :tunes, :user, foreign_key: true
  end
end
