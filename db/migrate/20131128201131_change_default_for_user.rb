class ChangeDefaultForUser < ActiveRecord::Migration
  def change
    change_column_default :users, :sms_credit, 0
  end
end
