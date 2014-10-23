class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.text :des
      t.string :cover
      t.hstore :detail
      t.string :short_name, nil: false
      t.boolean :public, default: true

      t.timestamps null: false
    end
  end
end
