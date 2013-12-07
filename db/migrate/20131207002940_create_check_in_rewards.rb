class CreateCheckInRewards < ActiveRecord::Migration
  def change
    create_table :check_in_rewards do |t|
      t.integer :user_id
      t.integer :check_in_count
      t.string :reward

      t.timestamps
    end
  end
end
