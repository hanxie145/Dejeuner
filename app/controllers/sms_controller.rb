class SmsController < ApplicationController
  include Plivo
  before_filter :authenticate_user!

  def send_message()
    # plivo stuff
    auth_id = "MAY2JJZJHLYTQ3YWMWND"
    auth_token = "ZDU2MDEwMzUwYTk1NTYxNjhjYmM3ZDEwMDU4NTU0"
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

    # send message and increment the user's sms sent count
    if p.send_message(params)
      # TODO update with actual value
      new_sms_sent_val = current_user.sms_sent + 10 
      current_user.update_attribute :sms_sent, new_sms_sent_val
    end

    flash[:notice] = "Message send successful"
    redirect_to main_path
  end

  def subscribers 
    set_user()
    @sms_contacts = current_user.sms_contacts
  end

end
