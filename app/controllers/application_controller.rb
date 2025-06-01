class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  #allow_browser versions: :modern
  before_action :set_session_token

  private

  def set_session_token
    session[:session_token] ||= SecureRandom.uuid
  end
end
