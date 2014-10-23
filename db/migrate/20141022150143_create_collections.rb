class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :title, null: false
      t.integer :maximum, default: 9999
      t.belongs_to :event, index: true
      t.text :des

      t.timestamps null: false
    end
  end
end
