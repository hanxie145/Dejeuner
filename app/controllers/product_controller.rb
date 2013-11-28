class ProductController < ApplicationController
  before_filter :authenticate_user!

  def main 
    set_user()
    @restaurant = @user.restaurant 
    my_reviews = current_user.reviews
    @reviews_count = my_reviews.count
    @new_reviews_today = my_reviews.where('created_at >= ?', Date.today).count
    my_campaigns = current_user.campaigns
    @current_campaign = my_campaigns.last.description
    @campaigns_count = my_campaigns.count
    @sms_count = current_user.sms_credit
    @contacts_count = current_user.sms_contacts.count
  end 

  def profile
    set_user()
    @name = @user.name
    @first_name = @name.split(' ')[0]
    @last_name = @name.split(' ')[1]
    @restaurant = @user.restaurant
    @numbers = @user.numbers
    @number = pluralize(@numbers.length, "Number")

    # TODO: get user plans
  end

  def market 
    set_user()
  end
  
  def help 
    set_user()
  end
end
