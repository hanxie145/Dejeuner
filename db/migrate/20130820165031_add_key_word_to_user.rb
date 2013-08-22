class AddKeyWordToUser < ActiveRecord::Migration
  def change
    add_column :users, :key_word, :string
  end
end
