class SessionsController < ApplicationController

	def new
	end

	def create
		user=User.find_by(email: params[:sessions][:email].downcase)
		if user && user.authenticate(params[:sessions][:password])
		session[:user_id]=user.id
		flash[:notice]="You Have Logged in Succesfully to TAL-BLOGS"
		redirect_to users_path

		else
			flash.now[:notice]="OOPS THERE WAS SOMETHING WRONG WITH YOUR LOGIN DETAILS!!"
			render 'new'


		end
	end

	def destroy
		session[:user_id]=nil
		flash[:notice]="You are logged out Succesfully"
		redirect_to root_path
	end



end