class ApplicationController < ActionController::Base
  private

  def current_member
    return Member.find(session[:member_id]) if session[:member_id]
  end

  helper_method :current_member
end
