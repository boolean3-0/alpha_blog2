class UsersController < ApplicationController

 def new
    @user = User.new

 end

def create
    # debugger

    @user = User.new(user_params)

    if @user.save
        flash[:success] = "Congratulations! You have joined the movement #{@user.username}."
        redirect_to articles_path
    else
        print_to_console(@user.username)
        render 'new'
    end

end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

end