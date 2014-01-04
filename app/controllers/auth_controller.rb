class AuthController < ApplicationController
  before_action :correct_user
  
  private
  
  def correct_user
    unless @me.in_group("dkebro") || @me.in_group("dkepledge")
      flash[:error] = "You do not have acess to this page"
      redirect_to root_url
    end
  end
end
