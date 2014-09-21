class StaticPagesController < ApplicationController
  def home
    @user = User.new
    if signed_in?
      if @user.admin?
        render 'administradors/dashboard'
      else
        render 'users/dashboard'
      end
    end
  end

  def help
  end

  def about
  end

  def contact
  end
  
end
