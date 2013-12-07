class CheckInReward < ActiveRecord::Base
  belongs_to :user

  validates :check_in_count, presence: true
  validates :user_id, presence: true 
  validates :reward, presence: true
  validates_length_of :reward, within: 1..160, too_short: 'must be longer than that', too_long: 'must be less than 160 characters' 
end
