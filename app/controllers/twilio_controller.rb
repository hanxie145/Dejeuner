class TwilioController < ApplicationController

  def sms_response
    # respond to a text message from twilio
    review = params[:Body]
    number = params[:From]

    # hacccckkkkyyy
    tony = User.find_by_email('txie145@gmail.com')[0]

    tony.reviews.create(body: review)
    tony.numbers.create(number: number )

    render 'sms-response.xml.erb', :content_type => 'text/xml'
  end 

end
