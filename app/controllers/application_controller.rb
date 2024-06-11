class ApplicationController < ActionController::Base
  helper_method :current_member

  class LoginRequired < StandardError; end
  class Forbidden < StandardError; end

  private

  def login_required
    raise LoginRequired unless current_member
  end

  def current_member
    return Member.find(session[:member_id]) if session[:member_id]
  end
end
