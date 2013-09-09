class Campaign < ActiveRecord::Base
  belongs_to :user

  validates :campaign_type, presence: true
  validates :description, presence: true
  validates :description, length: {maximum: 400}

end
