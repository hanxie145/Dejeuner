class CheckInReward < ActiveRecord::Base
  belongs_to :user

  validates :check_in_count, presence: true
  validates_numericality_of :check_in_count, only_integer: true, greater_than: 0, less_than: 50
  validates :user_id, presence: true 
  validates :reward, presence: true
  validates_length_of :reward, within: 1..100, too_short: 'must be longer than that', too_long: 'must be less than 100 characters' 
end
