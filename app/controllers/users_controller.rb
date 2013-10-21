class UsersController < ApplicationController
	before_action :set_user, only: [:show,:edit,:update,:destroy]
  def new
  	@user = User.new
  end

def create
  @user = User.new(user_params)
  if @user.save
    session[:user_id] = @user.id
    flash[:notice] = "You have signed up successfully."
    redirect_to projects_path
  else
    render :new
  end 
end

def edit
#		@project = Project.find(params[:id])
end

def update
#		@project = Project.find(params[:id])
  		if @user.update(user_params)
  			flash[:notice] = "User Profile has been updated."
  			redirect_to @user
  		else
			flash[:alert] = "User Profile has not been updated."
			render "edit"
  		end	
	end




private
  def user_params
    params.require(:user).permit(:name, :email,
                                 :password, :password_confirmation )
end
private
 def set_user
	    @user = User.find(params[:id])
  end

  def show
  end
end
