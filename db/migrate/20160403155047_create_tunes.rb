class CreateTunes < ActiveRecord::Migration
  def change
    create_table :tunes do |t|
      t.string :poster
      t.string :url
      t.text :poster_comment

      t.timestamps null: false
    end
  end
end
