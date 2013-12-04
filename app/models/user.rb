class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  # devise attributes
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # validates
  validates :name, presence: true, length: {maximum: 200}
  validates :email, uniqueness: true, 
                    uniqueness: { case_sensitive: false }

  # relations
  has_many :numbers, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :campaigns, dependent: :destroy
  has_many :sms_contacts, dependent: :destroy
  has_many :marketing_blasts, dependent: :destroy

  has_one :sms_response, dependent: :destroy
  has_one :current_campaign, dependent: :destroy, class_name: "Campaign"

  def create_review(body, from_number)
    self.reviews.create(body: body, from_number: from_number)
  end
end
