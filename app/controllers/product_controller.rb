class ProductController < ApplicationController
  before_filter :authenticate_user!

  def main 
    @user = current_user
    @restaurant = @user.restaurant 
  end 

  def profile
    @user = current_user
    @name = @user.name
    @restaurant = @user.restaurant

    # TODO: get user plans
  end
  
end
