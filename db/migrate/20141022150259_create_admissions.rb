class CreateAdmissions < ActiveRecord::Migration
  def change
    create_table :admissions do |t|
      t.belongs_to :collection, index: true
      t.integer :user_id
      t.string :secret, null: false
      t.boolean :signed, default: false
      t.boolean :available, default: true
      t.hstore :detail

      t.timestamps null: false
    end
  end
end
