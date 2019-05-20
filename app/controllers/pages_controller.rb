class PagesController < ApplicationController


    def home
        # We only want users who aren't logged in to be able to see the inbound page.
        redirect_to articles_path if logged_in?
    end

    def about

    end

end