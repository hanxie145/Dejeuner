class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ActionView::Helpers::TextHelper, ApplicationHelper
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  # for devise routing
  def after_sign_in_path_for(resource)
    main_path
  end

  def after_sign_up_path_for(resource)
    main_path
  end

  protected 

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :business_name) }
    devise_parameter_sanitizer.for(:account_update) { |u| 
      u.permit(:email, :name, :password, :password_confirmation, :current_password, :business_name, :time_zone) 
    }
  end
    
end
