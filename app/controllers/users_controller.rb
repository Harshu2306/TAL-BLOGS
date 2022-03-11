class UsersController < ApplicationController

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
			flash[:notice]="Welcome to TAL-BLOGS #{@user.username} , You have signed up successfully!!"
			redirect_to articles_path

		else
			render 'new'
		end

	end

private 

def user_params

	params.require(:user).permit(:username,:email,:password)

end

end

