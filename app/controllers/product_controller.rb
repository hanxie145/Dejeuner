class ProductController < ApplicationController
  before_filter :authenticate_user!

  def main 
    @user = current_user
    @restaurant = @user.restaurant 

    # get reviews
    twilio_sid = "ACfffe2a378d744f6c9c2a280c93a5be21"
    twilio_token = "374dca84e42fc9ca7f67319cb58b601a"
    twilio_phone_number = "2674158802"

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    # get all the reviews from logs for today
    reviews = []
    @reviews_today = @twilio_client.account.sms.messages.list(Date.today.to_s,to: "+12674158802").count

    # additional parameter: date_sent: Date.today.to_s,
    @twilio_client.account.sms.messages.list(to: "+12674158802").each do |message|

      # hardcode the number in
      # TODO switch to user.number in the future
      reviews.push(message.body)

    end

    # cut array 
    @reviews = reviews[0..4]
  end 

  def profile
    @user = current_user
    @name = @user.name
    @restaurant = @user.restaurant

    # TODO: get user plans
  end
  
end
