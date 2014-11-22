class API::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  def create
    @user = User.create(params[:user])
    if @user.save
      render :json => {:state => {:code => 0}, :data => @user }
    else
      render :json => {:state => {:code => 1, :messages => @user.errors.full_messages} }
    end
  end

  end
  