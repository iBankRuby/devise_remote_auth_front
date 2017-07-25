class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_auth_token

  protected

  def set_auth_token
    User.user = session[:auth_token]
  end
end
