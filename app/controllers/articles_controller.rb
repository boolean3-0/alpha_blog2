class ArticlesController < ApplicationController
    # The following line tells Rails to call the set_article method (private
    # method defined below) right before the edit, update, show, and destroy actions.
    # Note that if you have multiple calls to before_action in a controller, the actions
    # are run from top to bottom. I.e., always make sure that your before_actions calls
    # are in the order that you want them to execute.
    before_action :set_article, only: [:edit, :update, :show, :destroy]

    # For all the actions except the index and show actions, we need the user to be logged in.
    # We also have to make sure that, even for logged-in users, they can't edit 
    # or destory articles they didn't create.
    # Note that including this in the controller safeguards against people reaching pages they shouldn't
    # have access to through the URL.
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def index

        # @articles = Article.all
        
        # See https://github.com/mislav/will_paginate for info about this syntax and the
        # will_paginate gem.
        @articles = Article.paginate(page: params[:page], per_page: 5)

        # print_to_console(@articles)
    end

    # Displays new article form (new.html.erb)
    def new
        # Create a new instance of Article, our model class for the 
        # articles table. This instance variable is then available in
        # our view for the new action (i.e., in the new.html.erb file).
        # For more details about this Rails magic:
        # https://stackoverflow.com/questions/18773172/rails-how-do-controllers-pass-instance-variables-to-views-can-it-be-stopped/18774043
        # https://medium.com/@eric.programmer/removing-the-hack-in-rails-controllers-52396463c40d
        @article = Article.new

        # print_to_console(params)

    end

    # Displays edit article form (edit.html.erb)
    def edit
        
    end



    # The create method automatically receives params from the new article form submission.
    # (This form is contained in new.html.erb.)
    # Thus, it handles the new article form submission.
    def create

        # Uses the byebug gem (automatically included in Rails) to create a breakpoint
        # so that we can see the values of variables at this point + run through
        # execution line by line from here on out.
        # See: https://github.com/deivid-rodriguez/byebug
        # debugger

        # The line below lets us see params[:article].
        # I added parentheses to make it easier to read, but it can also
        # be written as "render plain: params[:article].inspect".
        # Note: params is actually an object, not a Ruby Hash!
        # See: https://eileencodes.com/posts/actioncontroller-parameters-now-returns-an-object-instead-of-a-hash/
        # render(plain: (params[:article].inspect))
        
        # print_to_console(params)

        @article = Article.new(article_params)

        # Set the creator to be the current user
        @article.user = current_user

        if @article.save
            # See: https://api.rubyonrails.org/classes/ActionDispatch/Flash.html
            # Also: http://www.xyzpub.com/en/ruby-on-rails/3.2/flash.html
            # Note that :success gives you green
            flash[:success] = 'Article was successfully created.'

            # This redirects to the articles#show action for this article.
            # Remember, to get the path for the show action, run "rails routes"
            # and then look at the "Prefix" column for the articles#show action. Append
            # "_path" to what you see there to get the path. We must pass in @article
            # because the URL requires the article id. (I guess Rails pulls out
            # the article id behind the scenes.)
            redirect_to article_path(@article)
        else

            # print "\n--------------------------------------------------\n"
            # puts @article
            # print "--------------------------------------------------\n\n"

            # print_to_console(@article.description)

            # Render the new.html.erb template once again if we fail to save
            # We could also use a symbol: "render :new"
            render 'new'
        end

    end

    # Handles the edit article form submission (edit.html.erb)
    def update
        
        # print_to_console(@article)

        # print_to_console(params)

        if @article.update(article_params)

            flash[:success] = 'Article was successfully updated.'
            redirect_to article_path(@article)
        else
            render 'edit'
        end
    end
        
    def show

        # print_to_console(params)

        
    end


    def destroy
        

        @article.destroy

        # :danger makes it red
        flash[:danger] = "Article was successfully deleted."

        redirect_to articles_path
    end

    
    private

        def set_article
            @article = Article.find(params[:id])
        end

        # Whitelist whatever has been submitted
        def article_params

            params.require(:article).permit(:title, :description)


        end

        # Used to ensure that users can't edit/delete articles they didn't create
        def require_same_user

            # We know current_user isn't nil because we ran require_user before this method.
            # See the order of the before_action calls at the top of this controller.
            # Likewise, we know that @article is defined because set_article is called before
            # this method thanks to the order of our before_action calls.
            if current_user != @article.user && !current_user.admin?
                flash[:danger] = "You can only edit or delete your own articles."
                redirect_to root_path

            end
        end

end


# Helper for printing to console
def print_to_console(input)
    print "\n--------------------------------------------------\n"
    print "#{input}\n"
    print "--------------------------------------------------\n\n"
end

# Method to test something
def test
    session[:user_id] = nil
    current_user
end