class ChargesController < ApplicationController

  def new 
  end 

  def create
    # Amount in cents
    @amount = 500 

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail, 
      :card => params[:stripeToken], 
      :plan => 'dejeuner-petit'
      )

    # if Stripe::Charge.create(
    #   :customer => customer.id,
    #   :amount => @amount, 
    #   :description => 'Rails Stripe customer', 
    #   :currency => 'usd'
    #   )
    #   flash[:notice] = "payment successful"
    # end

    rescue Stripe::CardError => e 
      flash[:error] = e.message
      redirect_to charges_path
  end 

end
