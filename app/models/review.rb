class Review < ActiveRecord::Base
  belongs_to :user

  validates :body, presence: true
  validates :from_number, presence: true
end
