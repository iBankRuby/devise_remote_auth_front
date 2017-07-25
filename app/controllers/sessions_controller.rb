class SessionsController < ApplicationController
  def new
  end

  def create
    response = User.post(:sign_in, :email => params[:user][:email], :password => params[:user][:password])
    if response.code == "201"
      response_body = JSON.parse(response.body)
      session[:auth_token] = response_body["authentication_token"]
      session[:current_user_id] = response_body["user_id"]
    end

    redirect_to root_url and return
  end

  def destroy
    response = User.delete(:sign_out)
    # TODO might want to check response to make sure it worked..

    # clean up our session and instance variables
    session.delete(:auth_token)
    session.delete(:current_user_id)
    @current_user = nil

    redirect_to root_url and return
  end

  helper_method :current_user

  protected

  def current_user
    @_current_user ||= session[:current_user_id] && User.find(session[:current_user_id])
  end
end
