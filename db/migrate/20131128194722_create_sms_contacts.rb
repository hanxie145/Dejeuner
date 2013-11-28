class CreateSmsContacts < ActiveRecord::Migration
  def change
    create_table :sms_contacts do |t|
      t.string :number
      t.integer :user_id

      t.timestamps
    end
  end
end
