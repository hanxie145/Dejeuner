class SmsContact < ActiveRecord::Base
  belongs_to :user

  validates :number, presence: true
  validates_uniqueness_of :number, scope: :user_id
end
