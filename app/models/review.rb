class Review < ActiveRecord::Base
  belongs_to :user

  validates :body, presence: true
  validates :from_number, presence: true

  # scopes
  scope :today, -> { where('created_at >= ?', Date.today) }
  scope :this_month, -> {where('created_at >= ?', Date.today.beginning_of_month)}

end
