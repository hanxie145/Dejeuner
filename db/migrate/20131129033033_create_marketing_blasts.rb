class CreateMarketingBlasts < ActiveRecord::Migration
  def change
    create_table :marketing_blasts do |t|
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end
