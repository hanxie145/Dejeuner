class ChargesController < ApplicationController
  before_filter :authenticate_user!
  # sms credit price to change in future
  PRICE_SMS_CREDITS = 3.5

  def upgrade_plan 
    set_user()
  end

  def new 
    set_user()
    @email = @user.email
    type = params[:type]
    # if the type of charge is to refill sms credits 
    if type === 'sms_credit_refill'
      # figure out how many credits the user is paying for and what price he should pay for them
      credits = params[:num_sms_credits]
      @price = credits.to_i * PRICE_SMS_CREDITS / 100
      @user_action = "Paying $#{@price} for #{credits} sms credits at $#{PRICE_SMS_CREDITS / 100.00} per credit"
      @display_price = "$" + @price.to_s
    else 
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
      @display_price = '$' + (@price / 100.00).to_s
    end
  end 

  def create
    set_user()
    @plan = params[:stripe_plan_id]
    response = Stripe::Customer.create(
      :email => params[:stripeEmail], 
      :card => params[:stripeToken], 
      :plan => @plan
      )
    if response
      # update user's plan and stripe customer id
      current_user.update_attribute :plan, @plan
      current_user.update_attribute :stripe_customer_id, response.id
      flash[:notice] = "Subscription successful. Congratulations, welcome to Dejeuner!"
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

  def destroy
    set_user
    customer = Stripe::Customer.retrieve(@user.stripe_customer_id)
    customer.cancel_subscription at_period_end: true
    flash[:notice] = "Your subscription will be cancelled at the end of your billing month, but your account will retain access to all the benefits of your subscription until then."  
    redirect_to profile_path 
  end

end
