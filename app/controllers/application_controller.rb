class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  before_action :authorize

  private

    def authorize
      unless user_login?
        flash[:danger] = "Please Sign up or Sign in."
        redirect_to home_path
      end
    end

end
