class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user, index: true
      t.string :content
      t.belongs_to :event, index: true

      t.timestamps null: false
    end
  end
end
