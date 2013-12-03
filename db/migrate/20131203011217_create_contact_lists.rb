class CreateContactLists < ActiveRecord::Migration
  def change
    create_table :contact_lists do |t|
      t.integer :user_id
      t.string :name

      t.timestamps
    end
  end
end
