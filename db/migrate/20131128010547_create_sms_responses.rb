class CreateSmsResponses < ActiveRecord::Migration
  def change
    create_table :sms_responses do |t|
      t.text :response
      t.integer :user_id

      t.timestamps
    end
  end
end
