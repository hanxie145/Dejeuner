class ProductController < ApplicationController
  include ProductHelper
  before_filter :authenticate_user!

  def main 
    set_user()
    @business = @user.business_name 

    # reviews 
    @reviews = current_user.reviews
    @reviews_count = @reviews.count
    @new_reviews_today = @reviews.today.count
    my_campaigns = current_user.campaigns
    @reviews_this_month = @reviews.this_month.count
    
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
    @subscribers_this_month = current_user.sms_contacts.this_month.count
  end 

  def profile
    set_user()
    @name = @user.name
    @first_name = @name.split(' ')[0]
    @last_name = @name.split(' ')[1]
    @business = @user.business_name
    @numbers = @user.numbers
    @number = pluralize(@numbers.length, "Number")
    @plan = @user.plan
  end

  def generate_sms 
    set_user()
  end

  def create_sms
  end

  def market 
    set_user
    # list of months 
    get_months
    @month_date = Time.now.month
    @day_date = Time.now.day
    @year_date = Time.now.year
    @month_values = (1..12).to_a
    @date_values = (1..31).to_a
    @year_values = (2013..2099).to_a
    # get current month for month select 
    @current_month_number = Time.now.month
  end

  def sms_credit_refill
    set_user()
  end
  
  def help 
    set_user()
  end
end
