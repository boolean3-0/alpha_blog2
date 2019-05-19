class UsersController < ApplicationController

    def new
        @user = User.new

    end

    def create
        # debugger

        # print_to_console(params)
        # print_to_console(user_params)
        # puts "\n\n\n\n\n\n"
        # puts params
        # puts "\n\n\n\n\n\n"

        @user = User.new(user_params)
        # testVar = User.create(username: 'testing12', email: 'testing@testin12g.com', password: 'pas12sword')

        # debugger

        # print_to_console(@user.username)

        # debugger

        if @user.save
            flash[:success] = "Congratulations! You have joined the movement #{@user.username}."
            redirect_to articles_path
        else
            # print_to_console(@user.username)
            render 'new'
        end

    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        # print_to_console(@user.class)

        @user = User.find(params[:id])

        if @user.update(user_params)
            flash[:success] = "Your account was updated successfully."
            redirect_to articles_path
        else
            render 'edit'
        end
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

end