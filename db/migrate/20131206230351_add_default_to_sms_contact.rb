class AddDefaultToSmsContact < ActiveRecord::Migration
  def change
    change_column_default :sms_contacts, :check_in_count, 0
  end
end
