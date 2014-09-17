class MicropostsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]
	before_filter :correct_user, only: :destroy

	def index
	end
	
	def create
		@micropost = current_user.microposts.build(params[:micropost])
		if @micropost.save
			flash[:success] = "Micropost created!"
			redirect_to root_path
		else
			@feed_items = []
			render 'static pages/home'
		end
	end
	
	def destroy
		@micropost.destroy
		redirect_back_or root_path
	end

	# Returns microposts from the users being followed by the given user.
	def self.from_users_followed_by(user)
		followed_user_ids = user.followed_user_ids
		where("user_id IN (:followed_user_ids) OR user_id = :user_id",
		followed_user_ids: followed_user_ids, user_id: user)
	end

	private
		def correct_user
			@micropost = current_user.microposts.find_by_id(params[:id])
			redirect_to root_path if @micropost.nil?
		end
end