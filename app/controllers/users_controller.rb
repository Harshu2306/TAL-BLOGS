class UsersController < ApplicationController
before_action :set_user, only: [:show, :edit, :update, :destroy]
before_action :require_user, only: [:edit,:update]
before_action :require_same_user, only:[:edit, :update]

	def show
		@user=User.find(params[:id])
		@articles=@user.articles.paginate(page: params[:page], per_page: 4)
	end

	def index

		@users = User.paginate(page: params[:page], per_page: 4)

	end

	def new
		@user = User.new
	end

	def edit
		@user=User.find(params[:id])
	end

	def update

		@user=User.find(params[:id])
		if @user.update(user_params)
			flash[:notice]="Your Account Information is updated successfully"
			redirect_to user_path

		else
			render 'edit'

		end
		
	end


	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id #(this line is written because we want to log the user in when he signup)
			flash[:notice]="Welcome to TAL-BLOGS #{@user.username} , You have signed up successfully!!"
			redirect_to articles_path

		else
			render 'new'
		end

	end

	def destroy
		@user.destroy
		session[:user_id]=nil if @user==current_user
		flash[:notice] ="Account and all asscoiated articles successfully deleted"
		redirect_to articles_path
	end

private 

def user_params

	params.require(:user).permit(:username,:email,:password)

end

def set_user

	@user=User.find(params[:id])

end


def require_same_user

	if current_user != @user && !current_user.admin?
		flash[:alert]="You can edit or delete your own account only!!!"
		redirect_to users_path

	end

	end

end

