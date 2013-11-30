class Campaign < ActiveRecord::Base
  belongs_to :user

  validates :description, presence: true
  validates :description, length: {maximum: 400}

end
