class API::SessionsController < Devise::SessionsController
  # https://github.com/plataformatec/devise/blob/master/app/controllers/devise/sessions_controller.rb
  respond_to :json
      protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/vnd.myapp.v1' }
  # POST /resource/sign_in
  # Resets the authentication token each time! Won't allow you to login on two devices
  # at the same time (so does logout).
    def create
   self.resource = warden.authenticate!(auth_options)
   sign_in(resource_name, resource)
 
   #current_user.update authentication_token: nil
   current_user.authentication_token= form_authenticity_token
   current_user.save
 
   respond_to do |format|
     format.json {
       render :json => {
         :user => current_user,
         :status => :ok,
         :authentication_token => current_user.authentication_token
       }
     }
   end
  end

  def destroy
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    sign_out
    render :json => { :info => "Logged out" }, :status => 200
  end

  def createface
  auth = request.env["omniauth.auth"]
  #auth = params[:user]
  user = User.where(:provider => auth['provider'], 
                    :uid => auth['uid']).first || User.from_omniauth(auth)
  #session[:user_id] = user.id
  #redirect_to root_url, :notice => "Signed in!"
  render :json => {
         :user => user.id,
         :status => :ok,
         :authentication_token => user.authentication_token
       }
end


end