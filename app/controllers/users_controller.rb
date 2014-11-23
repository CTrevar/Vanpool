	class UsersController < ApplicationController
  	#before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers, :obtener_cliente]
	#before_filter :correct_user, only: [:edit, :update]
	#before_filter :admin_user, only:[:dashboard], destroy:
  	
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
		ruta_id = params[:user][:ruta_id]
		@user = User.new(params[:user].except(:ruta_id))
		if @user.save!
			
        	
			sign_in @user
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
    		if ruta_id
    			redirect_to '/ver_rutas/#{ruta_id}'
    		else
				redirect_to :controller => 'clientes', :action => 'dashboard'
			end
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


		@current_cliente = obtener_cliente(current_user)
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:success] = "Profile updated"
			sign_in @user
			redirect_to :controller => 'clientes', :action => 'dashboard'
		else
			render 'edit'
		end
	end

	

	def dashboard
  		@users = User.paginate(page: params[:page])
      if current_user.admin?
        render 'administradors/dashboard'
      else
        render 'users/dashboard'
      end
  end

    def obtener_cliente(user)
      @cliente = Cliente.find_by_user_id(user.id)
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
