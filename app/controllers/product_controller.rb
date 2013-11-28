class ProductController < ApplicationController
  before_filter :authenticate_user!

  def main 
    set_user()
    @restaurant = @user.restaurant 
    @reviews_count = current_user.reviews.count
    @new_reviews_today = current_user.reviews.where('created_at >= ?', Date.today).count
    @campaigns_count = current_user.campaigns.count
    @sms_count = current_user.sms_credit
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
