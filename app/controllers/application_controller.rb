class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_user

  private 
  def check_user 
    authenticate_user! unless request.fullpath.include? "/admin"
  end

end
