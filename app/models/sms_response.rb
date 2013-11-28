class SmsResponse < ActiveRecord::Base
  belongs_to :user

  validates :response, presence: true
  validates_length_of :response, within: 1..160, too_short: 'must be longer than that', too_long: 'must be less than 160 characters' 

end
