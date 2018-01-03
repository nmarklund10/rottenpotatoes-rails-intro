class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :initialize_session
  def initialize_session
    session[:checked_ratings] ||= Movie.all_ratings
    session[:str] ||= ""
  end
end
