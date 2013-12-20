class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /campaigns
  # GET /campaigns.json
  def index
    set_user()
    @campaigns = @user.campaigns
    @current_campaign_description = (@user.campaigns.any? ? @user.campaigns.last.description : "")
    # @keyword = @user.key_word || ""
    # @numbers = current_user.numbers
    # @number = pluralize(@numbers.length, "Number")
    if @user.sms_response
      @reward = @user.sms_response.response
    else
      @reward = ""
    end
    @numbers = current_user.numbers
    @past_campaigns = @campaigns.slice(1, @campaigns.length)
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
  end

  def reward
    set_user()
    if @user.sms_response
      @current_reward = @user.sms_response.response
    end
    @sms_response = SmsResponse.new
  end

  def create_reward
    set_user() 
    @sms_response = current_user.build_sms_response response: params[:sms_response][:response]
    if @sms_response.save
      redirect_to campaigns_path, notice: 'Sms reward added / changed'
    else
      render action: 'reward'
    end
  end

  # GET /campaigns/new
  def new
    set_user()
    @campaign = Campaign.new
  end

  # GET /campaigns/1/edit
  def edit
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    set_user()
    @campaign = current_user.campaigns.new(campaign_params)

    respond_to do |format|
      if @campaign.save
        format.html { redirect_to campaigns_path, notice: 'Campaign was successfully created.' }
        format.json { render action: 'show', status: :created, location: @campaign }
      else
        format.html { render action: 'new' }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campaigns/1
  # PATCH/PUT /campaigns/1.json
  def update
    respond_to do |format|
      if @campaign.update(campaign_params)
        format.html { redirect_to @campaign, notice: 'Campaign was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    @campaign.destroy
    respond_to do |format|
      format.html { redirect_to campaigns_url }
      format.json { head :no_content }
    end
  end

  def key_word 
    @keyword = current_user.key_word || ""
  end

  # change keyword
  def update_key_word
    current_user.update_attributes({key_word: params[:key_word]})
    redirect_to campaigns_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_params
      params.require(:campaign).permit(:description, :campaign_type, :user_id)
    end
end
