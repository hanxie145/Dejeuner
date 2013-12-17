class User < ActiveRecord::Base
  include Plivo
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
  has_many :check_in_rewards, dependent: :destroy

  has_one :sms_response, dependent: :destroy
  has_one :current_campaign, dependent: :destroy, class_name: "Campaign"

  def create_review(body, from_number)
    self.reviews.create(body: body, from_number: from_number)
  end

  def is_trial
    self.plan === 'trial'
  end

  # Send sms message to the users contacts
  def send_sms_message(message)
    # plivo stuff
    auth_id = ENV["PLIVO_AUTH_ID"]
    auth_token = ENV["PLIVO_AUTH_TOKEN"]
    phone_numbers = ["17185772625", "17185771083", "17185750512", "17185750144", "17185584451"]

    # get msg and contacts
    message = message + ' Reply with STOP to unsubscribe.'
    contacts = self.sms_contacts

    # build dst field. For Plivo sending to more than one number is done by putting numbers in the dst field seperated by a <. E.g "number1<number2<number3"
    dst = ""
    for contact in contacts
      dst = "#{contact.number}<#{dst}"
    end

    p = RestAPI.new(auth_id, auth_token)
    params = {'src' => phone_numbers[0], 
             'dst' => dst, 
             'text' => message,
             'type' => 'sms',
        }
    # send message and increment the user's sms sent count while decrementing their sms_credits
    if p.send_message(params)
      new_sms_sent_val = self.sms_sent + contacts.count 
      new_sms_credit_val = self.sms_credit - contacts.count
      self.update_attribute :sms_sent, new_sms_sent_val
      self.update_attribute :sms_credit, new_sms_credit_val

      # save the text of the marketing blast for later 
      self.marketing_blasts.create :description => message
    end
  end
end
