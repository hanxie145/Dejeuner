class ProductController < ApplicationController
  before_filter :authenticate_user!

  def main 
    set_user()
    @restaurant = @user.restaurant 

    # reviews 
    @reviews = current_user.reviews
    @reviews_count = @reviews.count
    @new_reviews_today = @reviews.where('created_at >= ?', Date.today).count
    my_campaigns = current_user.campaigns
    @reviews_this_month = @reviews.where('created_at >= ?', Date.today.beginning_of_month).count
    
    if my_campaigns.any?
      @current_campaign = my_campaigns.last.description
    end
    @campaigns_count = my_campaigns.count
    @sms_count = current_user.sms_credit || 0
    @contacts_count = current_user.sms_contacts.count
    if @user.marketing_blasts.any?
      @last_marketing_blast = @user.marketing_blasts.last.description
    else
      @last_marketing_blast = "No marketing blasts sent yet"
    end

    # subscriber data for the sales chart. Get all subscribers by filtering from beginning of month 
    @subscribers_this_month = current_user.sms_contacts.where('created_at >= ?', Date.today.beginning_of_month).count
  end 

  def profile
    set_user()
    @name = @user.name
    @first_name = @name.split(' ')[0]
    @last_name = @name.split(' ')[1]
    @restaurant = @user.restaurant
    @numbers = @user.numbers
    @number = pluralize(@numbers.length, "Number")
    @plan = @user.plan
  end

  def market 
    set_user()
  end

  def sms_credit_refill
    set_user()
  end
  
  def help 
    set_user()
  end
end
