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

    # schedule messages
    delayed_jobs = Delayed::Job.where('user_id = ?', @user.id)
    @num_scheduled_messages_next_week = delayed_jobs.where('run_at <= ?', Time.zone.now + 1.week).count
    @next_message = delayed_jobs.order('run_at ASC').first
    if @next_message
      message = @next_message.handler.split('args').last
      @next_message_content = message.slice(4, message.length)
    end

    # loyalty rewards 
    @loyalty_rewards = @user.check_in_rewards.order(:check_in_count)

    # subscriber data for the sales chart. Get all subscribers by filtering from beginning of month 
    @subscribers_this_month = current_user.sms_contacts.this_month.count
    days_in_month = Time.days_in_month(Time.now.month, Time.now.year)
    # data for the subscribers graph. Get subscriber data by date
    graphData = Array.new(days_in_month, 0)
    for contact in current_user.sms_contacts.this_month
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

  def create_sms
  end

  def market 
    set_user
    # list of months 
    get_months

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
