class UsersController < ApplicationController

    # Before running the edit, update, or show actions,
    # run the set_user method. The point is to avoid
    # repeating code.
    before_action :set_user, only: [:edit, :update, :show, :destroy]

    before_action :require_same_user, only: [:edit, :update, :destroy]

    before_action :require_admin, only: [:destroy]

    def index
        # @users = User.all

        @users = User.paginate(page: params[:page], per_page: 5)
    end

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

            # This line ensure that the user is automatically logged in after signing up.
            session[:user_id] = @user.id

            flash[:success] = "Congratulations! You have joined the movement #{@user.username}."
            redirect_to user_path(@user)
        else
            # print_to_console(@user.username)
            render 'new'
        end

    end

    def edit
        
    end

    def update
        # print_to_console(@user.class)

        

        if @user.update(user_params)
            flash[:success] = "Your account was updated successfully."
            redirect_to articles_path
        else
            render 'edit'
        end
    end

    def show
   

        @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end

    def destroy

        # The line below destroys not only the user but all of the user's articles.
        # This is because of the "has_many :articles, dependent: :destroy" line at the top
        # of the User model class.
        @user.destroy

        flash[:danger] = "The user and all articles created by the user have been deleted."

        redirect_to users_path
    end

    # The private keyword applies to all methods below it.
    private

        def user_params
            params.require(:user).permit(:username, :email, :password)
        end

        def set_user
            @user = User.find(params[:id])
        end

        def require_same_user
            
            if current_user != @user && !current_user.admin?
                flash[:danger] = "You can only edit your own account."
                redirect_to root_path
            end
        end

        def require_admin
            if logged_in? && !current_user.admin?
                flash[:danger] = "Only admin users can perform that action."
                redirect_to root_path
            end
        end

end