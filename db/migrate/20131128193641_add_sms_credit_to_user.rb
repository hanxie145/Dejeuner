class AddSmsCreditToUser < ActiveRecord::Migration
  def change
    add_column :users, :sms_credit, :integer
  end
end
