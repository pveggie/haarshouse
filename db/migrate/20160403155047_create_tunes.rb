class CreateTunes < ActiveRecord::Migration[4.2]
  def change
    create_table :tunes do |t|
      t.string :poster
      t.string :url
      t.text :poster_comment

      t.timestamps null: false
    end
  end
end
