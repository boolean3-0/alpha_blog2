# All other controller classes inherit from this one.

# Methods in this class are available to all your controllers, but they are
# not available to your views by default.

class ApplicationController < ActionController::Base

    # This line lets Rails know that current_user and logged_in? are helper methods.
    # As a result, they become available to use in our views.
    helper_method :current_user, :logged_in?

    # Returns the current user if someone is logged in
    def current_user

        # print_to_console(session[:user_id])

        (@current_user ||= User.find(session[:user_id])) if session[:user_id]
    end

    # Return whether a user is logged in currently
    def logged_in?
        # For !! see: https://stackoverflow.com/questions/3821428/what-does-the-symbol-mean-in-ruby

        
        # print_to_console(!!current_user)
        # print_to_console(@current_user)

        !!current_user
    end

    # Used for actions that require the user to be logged in
    def require_user
        if !logged_in?
            flash[:danger] = "You must be logged in to perform that action."
            redirect_to root_path
        end
    end

end
