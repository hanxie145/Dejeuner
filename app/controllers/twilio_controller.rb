class TwilioController < ApplicationController

  def sms_response
    # respond to a text message from twilio
    review = params[:Body]

    # hacccckkkkyyy
    tony = User.find_by_email('txie145@gmail.com')[0]

    tony.reviews.create(body: review)

    render 'sms-response.xml.erb', :content_type => 'text/xml'
  end 

end
