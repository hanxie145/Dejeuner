class DelayedJobsController < ApplicationController
  before_filter :authenticate_user!

  def index
    set_user
    @scheduled_messages = Delayed::Job.where('user_id = ?', @user.id)
    respond_to do |format|
      format.json {render layout: 'empty'}
    end
  end

  def delete
  end
end
