class AddSubcriberLimitToUser < ActiveRecord::Migration
  def change
    add_column :users, :subscriber_limit, :integer, default: 100
  end
end
