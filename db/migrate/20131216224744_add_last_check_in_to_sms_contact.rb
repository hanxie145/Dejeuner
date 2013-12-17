class AddLastCheckInToSmsContact < ActiveRecord::Migration
  def change
    add_column :sms_contacts, :last_check_in, :datetime
  end
end
