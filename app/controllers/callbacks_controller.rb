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

    if Cliente.find_by_user_id(@user.id)
      redirect_to :controller => 'clientes', :action => 'dashboard'
    else
      @cliente = Cliente.create(puntaje:0,nivel_id:1,user_id:@user.id)
      #flash[:success] = "Welcome to the Sample App!"
      # Tell the UserMailer to send a welcome email after save
      # UserMailer.welcome_email(@user).deliver

      @openpay=OpenpayApi.new('muvdvkft3dzo57bfzv5g','sk_aa543af9dc964f83b41418a26aa6104f')
   
      @customers=@openpay.create(:customers)
        request_hash={
          "external_id" => nil,
          "name" => @cliente.user.name,
          "last_name" => nil,
          "email" => @cliente.user.email,
          "requires_account" => true,
        }
        response_hash=@customers.create(request_hash.to_hash)
        @cliente.openpay_id=response_hash["id"]
        @cliente.save
        redirect_to :controller => 'clientes', :action => 'dashboard'
    end

        
    end
end