class AddDefaultToPlanForUser < ActiveRecord::Migration
  def change
    change_column_default :users, :plan, "trial"
  end
end
