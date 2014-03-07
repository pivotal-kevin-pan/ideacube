class UsersController < ApplicationController
	def index
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			redirect_to @user
		else
			render 'new'
		end
	end

	def show
		@user = User.find(params[:id])
		@ideas = @user.ideas.paginate(page: params[:page], :per_page => 5, order: "created_at DESC")
	end

	private
		def user_params
			params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
		end
end