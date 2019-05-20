class SessionsController < ApplicationController

    # Renders a login form
    def new

    end

    # Handles the login form submission, starts the session, and displays 
    # that the user is logged in
    def create
        # debugger

        # render 'new'

        # print_to_console(params)

        # Find the user by email
        user = User.find_by(email: params[:session][:email].downcase)

        # We specify two conditions:
        # 1. There exists a user with such an email (first condition).
        # 2. That user has the given password (second condition). Remember, the "authenticate"
        # method returns true if you give it the correct password.
        if user && user.authenticate(params[:session][:password])

            # How do we stimulate logging in?
            # The information is stored in a session hash which your browser backs.
            # The line below basically saves the user id in your session. So your
            # browser's cookies are going to handle this. The user id you set will be
            # stored by your browser and then used for requests to simulate that the 
            # user is logged in (and not just a regular user who isn't logged in). For a regular
            # user who isn't logged in, the user id will be nil.

            # I.e., you are saving this user's id in your session hash, which is backed
            # by your browser's cookies.

            # To really understand it, check out this awesome article:
            # https://www.theodinproject.com/courses/ruby-on-rails/lessons/sessions-cookies-and-authentication
            session[:user_id] = user.id

            flash[:success] = "You have successfully logged in."

            redirect_to user_path(user)
        else

            # Why did we use flash.now instead of flash?
            # flash persists for one http request. That's why after you redirect, you
            # can see the message on the next screen.
            # But when you render 'new' again, it isn't considered a new request.
            # So if you use flash here, the message will persist on the rerendered new
            # template plus the page after that as well. Obviously we don't want this,
            # so we use flash.now
            flash.now[:danger] = "There was something wrong with your login information."

            # Render sessions/new.html.erb if they fail to log in.
            # Note that since this form isn't model-backed, Rails isn't going to create any
            # validation messages. We have to create our own.
            render 'new'
        end
    end

    # Stops the session and moves the user to the logged-out state
    def destroy

        session[:user_id] = nil
        flash[:success] = "You have logged out."
        redirect_to root_path

    end

end