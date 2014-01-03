class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :set_user
  
  def set_user
    BrothersPersonal
    BrothersMit
    BrothersDke
    MitStudents
    @me = Apache.new(session[:uname])
  end
  
end
