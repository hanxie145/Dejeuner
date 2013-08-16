class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :description
      t.string :type
      t.integer :user_id

      t.timestamps
    end
  end
end
