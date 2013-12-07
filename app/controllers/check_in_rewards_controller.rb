class CheckInRewardsController < ApplicationController
  def new
    set_user()
    @check_in_reward = CheckInReward.new
    @current_rewards = @user.check_in_rewards
  end

  def create
    set_user()
    @check_in_reward = CheckInReward.new
    @current_rewards = @user.check_in_rewards
    
    check_in_number = params[:check_in_number]
    reward = params[:reward]
    @check_in_reward = @user.check_in_rewards.new reward: reward, check_in_count: check_in_number
    if @check_in_reward.save 
      redirect_to new_check_in_reward_path, notice: 'Successfully created check in reward'
    else 
      render action: "new"
    end
  end

  def destroy
    set_user()
  end
end
