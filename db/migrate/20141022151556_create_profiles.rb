class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.belongs_to :user, index: true
      t.string :name
      t.integer :mobile
      t.string :avatar
      t.integer :sex
      t.integer :qq
      t.string :wechat

      t.timestamps null: false
    end
  end
end
