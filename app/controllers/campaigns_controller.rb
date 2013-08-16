class CampaignsController < ApplicationController
  before_filter :authenticate_user!

  def index 
    @user = current_user
    @current_campaign = @user.campaigns.last
  end 

  def new 
    @campaign = current_user.campaigns.new
  end 

  def create 
    @campaign = current_user.campaigns.new(params[:campaign])

    if @campaign.save
      redirect_to campaigns_path
    else 
      render :new
    end
  end 

  def destroy 
  end 

end
