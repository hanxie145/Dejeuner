class ProductController < ApplicationController
  before_filter :authenticate_user!

  def main 
    set_user()
    @restaurant = @user.restaurant 

    # get reviews
    twilio_sid = "ACfffe2a378d744f6c9c2a280c93a5be21"
    twilio_token = "374dca84e42fc9ca7f67319cb58b601a"
    twilio_phone_number = "2674158802"

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    # get all the reviews from logs for today
    reviews = []
    @date = Date.today
    @date_today = @date.strftime("%A, %B %e")

    reviews_today = 0

    # additional parameter: date_sent: Date.today.to_s,
    # @twilio_client.account.sms.messages.list(to: "+12674158802").each do |message|

    #   # hardcode the number in
    #   # TODO switch to user.number in the future
    #   reviews.push(message.body)

    #   # check how many new messages for today by checking for date equality from twilio's message
    #   date = message.date_sent.slice(5..6)
    #   month = message.date_sent.slice(8..10)
    #   year = message.date_sent.slice(12..15)

    #   if((date == @date.mday.to_s) and (month == @date.strftime("%b")) and (year == @date.year.to_s))
    #     reviews_today = reviews_today + 1
    #   end

    #   # awww yea getting to use pluralize
    #   @reviews_today = pluralize(reviews_today, 'Review')

    # end

    # cut array 
    @reviews = reviews[0..4]
  end 

  def profile
    set_user()
    @name = @user.name
    @first_name = @name.split(' ')[0]
    @last_name = @name.split(' ')[1]
    @restaurant = @user.restaurant
    @numbers = @user.numbers
    @number = pluralize(@numbers.length, "Number")

    # TODO: get user plans
  end

  def market 
    set_user()
  end
  
  def help 
    set_user()
  end
end
