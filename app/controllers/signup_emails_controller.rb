class SignupEmailsController < ApplicationController
  before_action :set_signup_email, only: [:show, :edit, :update, :destroy]

  # GET /signup_emails
  # GET /signup_emails.json
  def index
    @signup_emails = SignupEmail.all
  end

  # GET /signup_emails/1
  # GET /signup_emails/1.json
  def show
  end

  # GET /signup_emails/new
  def new
    @signup_email = SignupEmail.new
  end

  # GET /signup_emails/1/edit
  def edit
  end

  def finish 
  end

  # POST /signup_emails
  # POST /signup_emails.json
  def create
    @signup_email = SignupEmail.new(signup_email_params)

    respond_to do |format|
      if @signup_email.save
        format.html { redirect_to "/signup_email/finish", notice: 'Signup email was successfully created.' }
        format.json { redirect_to root_path }
      else
        format.html { render action: 'new' }
        format.json { render json: @signup_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /signup_emails/1
  # PATCH/PUT /signup_emails/1.json
  def update
    respond_to do |format|
      if @signup_email.update(signup_email_params)
        format.html { redirect_to @signup_email, notice: 'Signup email was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @signup_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /signup_emails/1
  # DELETE /signup_emails/1.json
  def destroy
    @signup_email.destroy
    respond_to do |format|
      format.html { redirect_to signup_emails_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_signup_email
      @signup_email = SignupEmail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def signup_email_params
      params.require(:signup_email).permit(:email, :description)
    end
end
