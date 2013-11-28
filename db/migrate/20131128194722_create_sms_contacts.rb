class CreateSmsContacts < ActiveRecord::Migration
  def change
    create_table :sms_contacts do |t|
      t.integer :number
      t.integer :user_id

      t.timestamps
    end
  end
end
