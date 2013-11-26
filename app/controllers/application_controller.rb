class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  include ActionView::Helpers::TextHelper, ApplicationHelper
  
  # for devise routing
  def after_sign_in_path_for(resource)
    main_path
  end

  def after_sign_up_path_for(resource)
    main_path
  end

  protected 

  # add form attributes for devise sign ups
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :name, :restaurant, :password, :password_confirmation) }
  end

  # for devise edit 
   def devise_parameter_sanitizer
    if resource_class == User
      User::ParameterSanitizer.new(User, :user, params)
    else
      super
    end
  end 
  
end
