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
      # figure out if the user wants to the send the message now or later. 
      if params[:message_now_or_later] === 'now'
        @user.delay.send_sms_message params[:message]
        flash[:notice] = "Message send successful"
        redirect_to main_path
      elsif params[:message_now_or_later] === 'later'
        # get the time and create a new dateTime object
        params[:meridian] === 'PM' ? hour = params[:hour].to_i + 12 : hour = params[:hour].to_i
        minute = params[:minute].to_i
        date = params[:date]

        # get the year,month,day from the date string "yyyy-mm-dd"
        year = date.slice(0,4)
        month = date.slice(5,2)
        day = date.slice(8,2)

        # schedule the message according to the user's time zone. Create the message time in the user's time zone then convert to UTC +0000 (the application's time zone)
        Time.zone = @user.time_zone
        time_to_send_at = Time.zone.local(year, month, day, hour, minute, 0).in_time_zone('UTC')

        # Send the message in the background at the time specified
        @user.delay(run_at: time_to_send_at, user_id: @user.id).send_sms_message params[:message]
        flash[:notice] = "Message successfully scheduled."
        redirect_to '/scheduled_messages'
      end
    end
  end
end
