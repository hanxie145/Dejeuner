class SmsContact < ActiveRecord::Base
  include Plivo
  belongs_to :user

  validates :number, presence: true
  validates_uniqueness_of :number, scope: :user_id

  scope :this_month, -> {where('created_at >= ?', Date.today.beginning_of_month)}
  # scopes to figure out which customers have not been back for awhile or should be rewarded for their awesomeness
  scope :since_last_week, -> {where('last_check_in < ? AND last_check_in > ?', Date.today - 1.week, Date.today - 2.weeks)}
  scope :since_2_weeks, -> {where('last_check_in < ? AND last_check_in > ?', Date.today - 2.weeks, Date.today - 1.month)}
  scope :since_last_month, -> {where('last_check_in < ?', Date.today - 1.month)}
  scope :this_week, -> {where('last_check_in > ?', Date.today - 1.week)}
  scope :with_check_in_count_more_than, ->(check_in_count) { where('check_in_count > ?', check_in_count) }

  # method for customers checking in. Update the number's check_in_count by 1. Limit the check in count of a number to 1 a day. Save the number to the users subscribers list tnen after check in send a confirmation sms to a the number
  # TODO limit check ins to once a day
  def check_in 
    # save the contact to the user's list 
    new_check_in_count = self.check_in_count + 1
    self.update_attribute :check_in_count, new_check_in_count

    # update last_check_in attribute
    self.update_attribute :last_check_in, Time.zone.now.in_time_zone(self.user.time_zone)

    # get a list of check in rewards and see which one to send
    check_in_reward = self.user.check_in_rewards.where("check_in_count = ?", new_check_in_count).first
    if check_in_reward
      message = "Thanks for checking in. Show this sms to get " +check_in_reward.reward
      self.send_message message
    else
      message = "Thanks for checking in!"
      self.send_message message
    end
  end

  # send the confirmation message with the loyalty prize
  # TODO add in loyalty prize
  def send_message(message)
    # plivo stuff
    auth_id = ENV["PLIVO_AUTH_ID"]
    auth_token = ENV["PLIVO_AUTH_TOKEN"]
    phone_numbers = ["17185772625"]

    dst = self.number
    p = RestAPI.new auth_id, auth_token
    params = {'src' => phone_numbers[0], 
             'dst' => dst, 
             'text' => message,
             'type' => 'sms',
        }
    p.send_message params
  end

  # reset check in count to zero
  def reset_check_in_count 
    self.update_attribute :check_in_count, 0
  end
end
