class SmsResponseController < ApplicationController

  def sms_response
    # respond to a text message from twilio
    @from = params[:From]
    @to = params[:To]
    @text = params[:Text]

    # figure out which user it is 
    user = Number.where('number = ?', @to)[0].user 

    # check if customer has texted STOP and thus wants to unsubscribe
    unless @text.upcase === 'STOP'
      user.create_review(@text, @to)
      user.sms_contacts.create number: @from
      # figure out sms_response 
      @response = user.sms_response.response
      render 'sms_response.xml.erb', :content_type => 'text/xml'
    else
      unsubscribe_number = user.sms_contacts.where('number = ?', @from)[0]
      if unsubscribe_number
        unsubscribe_number.destroy
      end
      render 'unsubscribe.xml.erb', :content_type => 'text/xml'
    end
  end
end
