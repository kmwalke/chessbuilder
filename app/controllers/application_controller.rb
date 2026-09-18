class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  helper_method :current_user, :logged_in

  def current_user
    if session[:current_user_id]
      @current_user ||= User.find(session[:current_user_id])
    else
      @current_user = nil
    end
  end

  def logged_in
    return unless current_user.nil?

    session[:orig_destination] = request.path
    redirect_to login_path
  end

  def logged_in_as_admin
    return if current_user.role == User::ADMIN

    redirect_to root_path
  end

  private

  def game_action(redirect: false, path: root_path)
    ActiveRecord::Base.transaction do
      yield
    rescue StandardError => e
      @notice = if Rails.env.development?
                  e.to_s
                else
                  ErrorMessages::GENERIC[:error]
                end
    ensure
      redirect_to path, notice: @notice if redirect
    end
  end
end
