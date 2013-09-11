class CreateSignupEmails < ActiveRecord::Migration
  def change
    create_table :signup_emails do |t|
      t.string :email
      t.text :description

      t.timestamps
    end
  end
end
