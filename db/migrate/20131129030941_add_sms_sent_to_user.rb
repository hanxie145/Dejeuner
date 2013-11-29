class AddSmsSentToUser < ActiveRecord::Migration
  def change
    add_column :users, :sms_sent, :integer
  end
end
