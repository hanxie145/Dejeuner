class SmsContactsController < ApplicationController
  before_action :set_SmsContact, only: [:show, :edit, :update, :destroy]

  # GET /SmsContacts
  # GET /SmsContacts.json
  def index
    @sms_contacts = SmsContact.all
  end

  # GET /SmsContacts/1
  # GET /SmsContacts/1.json
  def show
  end

  # GET /SmsContacts/new
  def new
    @sms_contact = SmsContact.new
  end

  # GET /SmsContacts/1/edit
  def edit
  end

  # POST /SmsContacts
  # POST /SmsContacts.json
  def create
    @sms_contact = SmsContact.new(sms_contact_params)

    respond_to do |format|
      if @sms_contact.save
        format.html { redirect_to @sms_contact, notice: 'SmsContact was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sms_contact }
      else
        format.html { render action: 'new' }
        format.json { render json: @sms_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /SmsContacts/1
  # PATCH/PUT /SmsContacts/1.json
  def update
    respond_to do |format|
      if @sms_contact.update(sms_contact_params)
        format.html { redirect_to @sms_contact, notice: 'SmsContact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sms_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /SmsContacts/1
  # DELETE /SmsContacts/1.json
  def destroy
    @sms_contact.destroy
    respond_to do |format|
      format.html { redirect_to sms_contacts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_SmsContact
      @sms_contact = SmsContact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def SmsContact_params
      params.require(:SmsContact).permit(:SmsContact, :user_id)
    end
end
