class SessionsController < ApplicationController
def new
	@user = User.new
	render 'new'
end

def create
	@user = User.new
	user = User.find_by_email(params[:session][:email])
	if user && user.authenticate(params[:session][:password])
    sign_in user
    if (user.admin?)
      render 'administradors/dashboard'
    else
      render 'users/dashboard'
    end

    # Sign the user in and redirect to the user's show page.
	else
		flash.now[:error] = 'Invalid email/password combination' # Not quite right!
		render 'new'
	end
end

def destroy
	sign_out
	redirect_to root_path
end

end
