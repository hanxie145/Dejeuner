class CheckInsController < ApplicationController
  before_filter :authenticate_user!

  def new
    set_user()
  end

  def create
    set_user()

    # change number according to NA plivo standards
    number = "1" + params[:number]

    # create the sms contact for the user if they do not have one 
    unless @user.sms_contacts.where("number = ?", number).any?
      my_sms_contact = @user.sms_contacts.create number: number
      my_sms_contact.check_in
    else
      # update the customer's check in count by one.
      SmsContact.where('number = ?', number).first.check_in
    end
    flash[:notice] = "Check in successful for #{number}!"
    redirect_to action: 'new'
  end

  def loyalty
    set_user()
  end
end
