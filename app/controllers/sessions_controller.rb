class SessionsController < ApplicationController
def new
	@user = User.new
	render 'new'
end

def create
	@user = User.new
	user = User.find_by_email(params[:session][:email])
	if user && user.authenticate(params[:session][:password])
<<<<<<< HEAD
#<<<<<<< HEAD
		sign_in user
		redirect_to :controller => 'clientes', :action => 'dashboard'
#=======
=======
>>>>>>> 466b84c7eee686c1eff3d96cc9e8c68d2816b3c2
    sign_in user
    if (user.admin?)
      redirect_to :controller => 'administradors', :action => 'index'
    else
      redirect_to :controller => 'clientes', :action => 'dashboard'
    end

    # Sign the user in and redirect to the user's show page.
<<<<<<< HEAD
#>>>>>>> jTables
=======
>>>>>>> 466b84c7eee686c1eff3d96cc9e8c68d2816b3c2
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
