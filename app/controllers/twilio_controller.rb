class TwilioController < ApplicationController

  def sms_response
    # respond to a text message from twilio
    review = params[:Body]
    number = params[:From]

    # hacccckkkkyyy
    # tony = User.where('email = ?', 'txie145@gmail.com')[0]

    # unless review.nil?
    #   tony.reviews.create(body: review)
    # end

    # unless number.nil?
    #   tony.numbers.create(number: number )
    # end

    render 'sms_response.xml.erb', :content_type => 'text/xml'
  end 

end
