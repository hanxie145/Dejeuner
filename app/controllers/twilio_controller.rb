class TwilioController < ApplicationController

  def sms_response
    # respond to a text message from twilio
    review = params[:Body]
    number = params[:From]

    render 'sms_response.xml.erb', :content_type => 'text/xml'
  end 

end
