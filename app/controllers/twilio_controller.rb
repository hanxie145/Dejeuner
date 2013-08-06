class TwilioController < ApplicationController

  def sms_response
    # respond to a text message from twilio
    review = params[:Body]
    number = params[:From]

    render 'sms_response.xml.erb', :content_type => 'text/xml'

    # hacccckkkkyyy
    tony = User.where('email = ?', 'txie145@gmail.com')[0]

    tony.reviews.create(body: review)
    tony.numbers.create(number: number )

  end 

end
