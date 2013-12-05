class SmsController < ApplicationController
  before_filter :authenticate_user!, only: :send_message

  def send_message()
    set_user()

    # check if the user has enough sms credits remaining to send out this message 
    sms_credits_remaining = @user.sms_credit
    if sms_credits_remaining <= 0 
      flash[:notice] = "You do not have enough sms credits remaining! Please refill your sms credits."
      redirect_to market_path
    else
      # Send the message in the background
      current_user.delay().send_sms_message params[:message]
      flash[:notice] = "Message send successful"
      redirect_to main_path
    end
  end
end
