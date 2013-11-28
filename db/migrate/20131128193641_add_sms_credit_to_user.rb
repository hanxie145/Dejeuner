class AddSmsCreditToUser < ActiveRecord::Migration
  def change
    add_column :users, :sms_credit, :integer, default: 0
  end
end
