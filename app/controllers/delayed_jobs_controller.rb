class DelayedJobsController < ApplicationController
  before_filter :authenticate_user!

  def index
    set_user
    @scheduled_messages = Delayed::Job.where('user_id = ?', @user.id)
    respond_to do |format|
      format.html {}
      format.json {render layout: 'empty', content_type: 'application/json'}
    end
  end

  def destroy
    set_user
    @scheduled_message = Delayed::Job.where('id = ?', params[:id]).first
    @scheduled_message.destroy
    respond_to do |format|
      format.html {}
      format.json {}
    end
  end
end
