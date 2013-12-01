class ChargesController < ApplicationController
  before_filter :authenticate_user!

  def new 
    set_user()
    @email = @user.email
    @plan = params[:plan]

    # figure out the price
    case @plan 
    when "petite"
      @price = 4999
      @stripe_plan_id = 'dejeuner-petite'
    when "moyenne"
      @price = 9999
      @stripe_plan_id = 'dejeuner-moyenne'      
    when "grande"
      @price = 14999
      @stripe_plan_id = 'dejeuner-grande'      
    else 
      @price = 0
      @stripe_plan_id = ''      
    end
    @display_price = @price / 100.00
  end 

  def create
    set_user()
    @plan = params[:stripe_plan_id]
    if Stripe::Customer.create(
      :email => params[:stripeEmail], 
      :card => params[:stripeToken], 
      :plan => @plan
      )
      # update user's plan 
      current_user.update_attribute :plan, @plan
      flash[:notice] = "Successfully subscribed to Dejeuner"
      redirect_to main_path
    end

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
