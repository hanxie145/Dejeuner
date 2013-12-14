class CheckInsController < ApplicationController
  before_filter :authenticate_user!

  def new
    set_user()
  end

  def create
    set_user()

    # change number according to NA plivo standards
    number = "1" + params[:number]

    # create the sms contact for the user if they do not have one 
    unless @user.sms_contacts.where("number = ?", number).any?
      contact = @user.sms_contacts.create number: number
      contact.check_in
      @check_in_count = 1
    else
      # update the customer's check in count by one.
      contact = SmsContact.where('number = ?', number).first
      contact.check_in
      @check_in_count = contact.check_in_count
    end
    arr_of_check_in_count = @user.check_in_rewards.pluck :check_in_count
    # get number of check ins until the next reward
    for i in arr_of_check_in_count
      flag = false
      if @check_in_count < i && !flag
        @num_until_next_reward = i - @check_in_count
        flag = true
      end

      # if we reach the end of the array without setting @num_until_next_reward then it means the user has reached the last loyalty reward, so we set it to the last element of the array.
      if i === arr_of_check_in_count.last && !@num_until_next_reward
        @num_until_next_reward = i
      end
    end

    @reward = @user.check_in_rewards.where('check_in_count = ?', @check_in_count).first

    # if max checkin count has already been reached then reset to zero 
    if @check_in_count >= arr_of_check_in_count.last
      contact.reset_check_in_count 
      flash[:notice] = "Check in count has been reset because you have already hit the last loyalty reward!"
    else
      flash[:notice] = "Check in successful for #{number}!"
    end
  end

  def loyalty
    set_user()
  end
end
