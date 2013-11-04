class AuthController < ApplicationController
  before_filter :require_current_user
  before_filter :authenticate_user!

  def require_current_user
    redirect_to new_user_session_path if current_user.nil?
  end
end