class SmsController < ApplicationController
  include Plivo

  def send_message()
    # plivo stuff
    auth_id = "MAY2JJZJHLYTQ3YWMWND"
    auth_token = "ZDU2MDEwMzUwYTk1NTYxNjhjYmM3ZDEwMDU4NTU0"
    phone_numbers = ["17185772625", "17185771083", "17185750512", "17185750144", "17185584451"]

    message = params[:message]

    p = RestAPI.new(auth_id, auth_token)
    params = {'src' => phone_numbers[0], 
             'dst' => '16049108862', 
             'text' => message,
             'type' => 'sms',
        }

    # send message
    p.send_message(params)

    
    flash[:notice] = "Message send successful"
    redirect_to main_path
  end

end
