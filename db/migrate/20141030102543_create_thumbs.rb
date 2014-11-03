class CreateThumbs < ActiveRecord::Migration
  def change
    create_table :thumbs do |t|
      t.string :title
      t.string :file

      t.timestamps null: false
    end
  end
end
