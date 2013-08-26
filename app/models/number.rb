class Number < ActiveRecord::Base
  belongs_to :user

  validates :number, numericality: true
end
