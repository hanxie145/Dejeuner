class TwilioController < ApplicationController

  def sms_response
    # respond to a text message from twilio
    @from = params[:From]
    @to = params[:To]
    @text = params[:Text]

    # figure out which user it is 
    user = Number.where('number = ?', @to)[0].user 

    # save the review to the user 
    user.delay.create_review(@text, @to)

    # figure out sms_response 
    @response = user.sms_response.response

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

    # send message to all contacts from today
    # TODO: set it to send to contacts from all time
    # additional parameter: date_sent: Date.today.to_s,
    contact_numbers = client.account.sms.messages.list(date_sent: Date.today.to_s, to: "+12674158802").map{ |contact| contact.from}

    s1 = Set.new()

    for number in contact_numbers
      s1.add(number)
    end

    message = params[:message]

    # loop through numbers and send message
    for number_from in s1

      client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => number_from,
      :body => message
    )
    end

    redirect_to main_path

  end
end
