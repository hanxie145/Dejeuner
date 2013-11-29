class ChangeDefaultSmsSentForUser < ActiveRecord::Migration
  def change
    change_column_default :users, :sms_sent, 0
  end
end
