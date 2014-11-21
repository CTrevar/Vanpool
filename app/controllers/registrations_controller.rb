#class RegistrationsController < Devise::RegistrationsController
 
#  respond_to :json, :html
#def create

#user = User.new(params[:user])

#if user.save
#render :json=> user.as_json(:auth_token=>user.authentication_token, :email=>user.email), :status=>201
#return
#else
#warden.custom_failure!
#render :json=> user.errors, :status=>422
#end
#end

 #respond_to do |format|
 #   if @user.save
 #     flash[:notice] = 'User was successfully created.'
 #     format.html { redirect_to(@user) }
 #     format.js { render :json=> user.as_json(:auth_token=>user.authentication_token, :email=>user.email), :status=>201 }
 #   else
 #     format.html { render action: "new" }
 #     format.js { render :json=> user.errors, :status=>422 }
 #   end
 # end

  #def create
    #@user = User.create(params[:user])
    #if @user.save
     # render :json => {:state => {:code => 0}, :data => @user }
    #else
    #  render :json => {:state => {:code => 1, :messages => @user.errors.full_messages} }
   # end

 # end
  