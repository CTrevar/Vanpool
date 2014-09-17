class StaticPagesController < ApplicationController
  def home
    @user = User.new
    if signed_in?
  	   render 'users/dashboard'
    end
  end

  def help
  end

  def about
  end

  def contact
  end
  
end
