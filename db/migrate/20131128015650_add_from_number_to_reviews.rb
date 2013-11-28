class AddFromNumberToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :from_number, :string
  end
end
