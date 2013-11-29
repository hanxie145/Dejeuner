class SmsController < ApplicationController
  include Plivo
  before_filter :authenticate_user!

  def send_message()
    # plivo stuff
    auth_id = ENV[PLIVO_AUTH_ID]
    auth_token = ENV[PLIVO_AUTH_TOKEN]
    phone_numbers = ["17185772625", "17185771083", "17185750512", "17185750144", "17185584451"]

    # get msg and contacts
    message = params[:message]
    contacts = current_user.sms_contacts

    # build dst field. For Plivo sending to more than one number is done by putting numbers in the dst field seperated by a <. E.g "number1<number2<number3"
    dst = ""
    for contact in contacts
      dst = "#{contact.number}<#{dst}"
    end

    p = RestAPI.new(auth_id, auth_token)
    params = {'src' => phone_numbers[0], 
             'dst' => dst, 
             'text' => message,
             'type' => 'sms',
        }

    # send message and increment the user's sms sent count while decrementing their sms_credits
    if p.send_message(params)
      new_sms_sent_val = current_user.sms_sent + contacts.count 
      new_sms_credit_val = current_user.sms_credit - contacts.count
      current_user.update_attribute :sms_sent, new_sms_sent_val
      current_user.update_attribute :sms_credit, new_sms_credit_val

      # save the text of the marketing blast for later 
      current_user.marketing_blasts.create :description => message
    end

    flash[:notice] = "Message send successful"
    redirect_to main_path
  end

  def subscribers 
    set_user()
    @sms_contacts = current_user.sms_contacts
  end

end
