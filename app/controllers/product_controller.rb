class ProductController < ApplicationController
  include ProductHelper, GenerateSmsHelper
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

    # schedule messages
    delayed_jobs = Delayed::Job.where('user_id = ?', @user.id)
    @scheduled_messages_count = delayed_jobs.count
    @num_scheduled_messages_next_week = delayed_jobs.where('run_at <= ?', Time.zone.now + 1.week).count
    @next_message = delayed_jobs.order('run_at ASC').first
    if @next_message
      message = @next_message.handler.split('args').last
      @next_message_content = message.slice(4, message.length)
    end

    # loyalty rewards 
    @loyalty_rewards = @user.check_in_rewards.order(:check_in_count)

    # check ins 
    @check_ins_count = @user.sms_contacts.where('last_check_in > ?', Date.today).count

    # data for the piecharts
    subscribers = @user.sms_contacts
    h = Hash.new
    @subscribers_last_week = subscribers.since_last_week.count
    @subscribers_two_weeks = subscribers.since_2_weeks.count
    @subscribers_last_month = subscribers.since_last_month.count
    @subscribers_this_week = subscribers.this_week.count
    h[:this_week] = @subscribers_this_week
    h[:last_week] = @subscribers_last_week
    h[:two_weeks] = @subscribers_two_weeks
    h[:last_month] = @subscribers_last_month
    @piechart_subscriber_data = h

    # subscriber data for the sales chart. Get all subscribers by filtering from beginning of month 
    @subscribers_this_month = @user.sms_contacts.this_month.count
    days_in_month = Time.days_in_month(Time.now.month, Time.now.year)
    # data for the subscribers graph. Get subscriber data by date
    graphData = Array.new(days_in_month, 0)
    for contact in @user.sms_contacts.this_month
      day = contact.created_at.day
      graphData[day] = graphData[day] + 1
    end
    @graph_subscriber_data = *(1..days_in_month)
    for i in (0..graphData.length - 1)
      @graph_subscriber_data[i] = [i + 1, graphData[i]]
    end
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

  def schedule_sms
    set_user()
  end

  def create_sms
    set_user
    reward_type = params[:reward_type]
    if reward_type === 'coupon'
      reward = params[:coupon_reward]
    elsif reward_type === 'deal'
      reward = params[:deal_reward]
    end
      
    # generate the sms 
    sms = generate_sms_from_args(@user.business_name, params[:industry], params[:customer_segment], params[:date], params[:time_begin], params[:time_end], reward_type, reward)
    flash[:notice] = "Sms generated! Now just click the schedule button below to schedule it"
    redirect_to :action => 'market', sms: sms
  end

  def market 
    set_user
    # list of months 
    get_months
    @sms = params[:sms]

    # set the time zone and get today's date
    Time.zone = @user.time_zone
    @month_date = Time.zone.now.month
    @day_date = Time.zone.now.day
    @year_date = Time.zone.now.year
    @month_values = (1..12).to_a
    @date_values = (1..31).to_a
    @year_values = (2013..2099).to_a
    # get current month for month select 
    @current_month_number = Time.zone.now.month
  end

  def sms_credit_refill
    set_user()
  end
  
  def help 
    set_user()
  end
end
