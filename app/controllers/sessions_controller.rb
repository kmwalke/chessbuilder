class SessionsController < ApplicationController
  def new; end

  def create
    user = User.where('lower(email) = ?', params.expect(:email).strip.downcase).first
    if user&.authenticate(params[:password])
      session[:current_user_id] = user.id
      redirect_to root_path, notice: 'Logged in!'
    else
      redirect_to login_path, notice: 'Email or password is invalid'
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to root_path
  end
end
