class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]
    raise omniauth.inspect
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.authentications.create(:provider => omniauth['provider'], 
                                          :uid => omniauth['uid'],
                                          :access_token => omniauth["credentials"]["token"])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      user = User.where(:twitter_username => omniauth["info"]["nickname"]).first_or_initialize
      user.authentications.build(:provider => omniauth ['provider'], 
                                 :uid => omniauth['uid'], 
                                 :access_token => omniauth["credentials"]["token"])
      user.oauth_token = omniauth["credentials"]["token"]
      user.oauth_token_secret = omniauth["credentials"]["secret"]
      user.save!
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, user)
    end
    session[:auth] = current_user.authentication_token
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    session.delete("auth")
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end

  private 
  
  # def after_sign_in_path_for(resource)
  #   url = SERVICES_CONFIG["octochat"]["url"]
  #   stored_location_for(resource) || url
  # end
end
