class TwilioController < ApplicationController

  def sms_response
    # respond to a text message from twilio
    review = params[:Body]
    number = params[:From]

    render 'sms_response.xml.erb', :content_type => 'text/xml'
  end 

  def mass_message
  end

  def send_mass_message 
    # twilio credentials
    twilio_sid = "ACfffe2a378d744f6c9c2a280c93a5be21"
    twilio_token = "374dca84e42fc9ca7f67319cb58b601a"
    twilio_phone_number = "2674158802"

    client = Twilio::REST::Client.new twilio_sid, twilio_token

    # send message to 5 most recent contacts
    # additional parameter: date_sent: Date.today.to_s,
    contact_numbers = client.account.sms.messages.list(to: "+12674158802").map{ |contact| contact.from}

    contact_numbers = contact_numbers[0..1]

    message = params[:message]

    # loop through numbers and send message
    for number_from in contact_numbers

      client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => number_from,
      :body => message
    )
    end

    render 'product/main'

  end
end
