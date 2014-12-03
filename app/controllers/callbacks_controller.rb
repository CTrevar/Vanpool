class CallbacksController < Devise::OmniauthCallbacksController
    def facebook
        @user = User.from_omniauth(request.env["omniauth.auth"])
        #raise env["omniauth.auth"].to_yaml

        #if @user.persisted?
        	@oauth = Koala::Facebook::OAuth.new("708292565932035", "0961c370c701538ac20f349b9a02b4b3")
        	
        	session[:access_token] = request.env["omniauth.auth"].credentials.token
      #sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      #set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    #else
     # session["devise.facebook_data"] = request.env["omniauth.auth"]
     # redirect_to new_user_registration_url
    #end

        sign_in_and_redirect @user
        #sign_in_and_redirect dashboard_path
    end
end