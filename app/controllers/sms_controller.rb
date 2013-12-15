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
      # get the time and create a new dateTime object
      params[:meridian] === 'PM' ? hour = params[:hour].to_i + 12 : hour = params[:hour].to_i
      minute = params[:minute].to_i
      second = params[:second].to_i
      year = params[:year]
      month = params[:month]
      date = params[:date]

      # 
      Time.zone = @user.time_zone
      time_to_send_at = Time.zone.local(year, month, date, hour, minute, second).in_time_zone('UTC')

      # Send the message in the background at the time specified
      current_user.delay(run_at: time_to_send_at).send_sms_message params[:message]
      flash[:notice] = "Message send successful"
      redirect_to main_path
    end
  end
end
