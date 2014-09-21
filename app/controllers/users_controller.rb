class UsersController < ApplicationController
  	before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers, :dashboard, :profile]
	before_filter :correct_user, only: [:edit, :update]
	before_filter :admin_user, only:[:dashboard], destroy:
  	
  	def index
  		@users = User.paginate(page: params[:page])
	end

  	def new
  		@user = User.new
  	end
  
  	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User destroyed."
		redirect_to users_path
	end

	def create
		@user = User.new(params[:user])
		if @user.save	
			sign_in @user
			#flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			render 'new'
		end
	end


  	def show
		#@user = User.find(params[:id])
		@current_user = current_user
		#@microposts = @user.microposts.paginate(page: params[:page])
		render 'dashboard'
		#redirect_to dashboard
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			#flash[:success] = "Profile updated"
			sign_in @user
			redirect_to @user
		else
			render 'edit'
		end
	end

	def following
		@title = "Following"
		@user = User.find(params[:id])
		@users = @user.followed_users.paginate(page: params[:page])
		render 'show_follow'
	end

	def followers
		@title = "Followers"
		@user = User.find(params[:id])
		@users = @user.followers.paginate(page: params[:page])
		render 'show_follow'
	end

	def feed
		Micropost.from_users_followed_by(self)
	end

	def profile
		@title = "Perfil"
		@user = User.find(params[:id])
		@co2 = 2300
		@kilometros = 12000
		@dinero = 450
		render 'show_profile'
	end

	def dashboard
  		@users = User.paginate(page: params[:page])
      if current_user.admin?
        render 'administradors/dashboard'
      else
        render 'users/dashboard'
      end
  end


	private
		def signed_in_user
			store_location
			redirect_to signin_path, notice: "Please sign in." unless signed_in?
		end
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end
		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end
end
