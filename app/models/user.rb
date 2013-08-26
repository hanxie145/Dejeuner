class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  # devise attributes
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # validates
  validates :name, presence: true, length: {maximum: 200}
  validates :email, uniqueness: true

  # relations
  has_many :numbers 
  has_many :reviews 
  has_many :campaigns
end
