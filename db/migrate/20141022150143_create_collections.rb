class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :title, null: false
      t.integer :maximum, default: 9999
      t.string :event_id
      t.text :des

      t.timestamps null: false
    end
  end
end
