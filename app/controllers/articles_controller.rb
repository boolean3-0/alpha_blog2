class ArticlesController < ApplicationController

    def index
        # Grab all articles in database
        @articles = Article.all

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
        @article = Article.find(params[:id])
    end



    # The create method automatically receives params from the new article form submission.
    # (This form is contained in new.html.erb.)
    # Thus, it handles the new article form submission.
    def create

        # The line below lets us see params[:article].
        # I added parentheses to make it easier to read, but it can also
        # be written as "render plain: params[:article].inspect".
        # Note: params is actually an object, not a Ruby Hash!
        # See: https://eileencodes.com/posts/actioncontroller-parameters-now-returns-an-object-instead-of-a-hash/
        # render(plain: (params[:article].inspect))
        

        @article = Article.new(article_params)

        if @article.save
            # See: https://api.rubyonrails.org/classes/ActionDispatch/Flash.html
            # Also: http://www.xyzpub.com/en/ruby-on-rails/3.2/flash.html
            flash[:notice] = 'Article was successfully created.'

            # This redirects to the articles#show action for this article.
            # Remember, to get the path for the show action, run "rails routes"
            # and then look at the "Prefix" column for the articles#show action. Append
            # "_path" to what you see there to get the path. We must pass in @article
            # because the URL requires the article id. (I guess Rails pulls out
            # the article id behind the scenes.)
            redirect_to article_path(@article)
        else
            # Render the new.html.erb template once again if we fail to save
            # We could also use a symbol: "render :new"
            render 'new'
        end

    end

    # Handles the edit article form submission (edit.html.erb)
    def update
        @article = Article.find(params[:id])

        # print_to_console(params)

        if @article.update(article_params)

            flash[:notice] = 'Article was successfully updated.'
            redirect_to article_path(@article)
        else
            render 'edit'
        end
    end
        
    def show

        # print_to_console(params)

        @article = Article.find(params[:id])
    end


    def destroy
        @article = Article.find(params[:id])

        @article.destroy

        flash[:notice] = "Article was successfully deleted."

        redirect_to articles_path
    end

    # Whitelist whatever has been submitted
    private
    def article_params

        params.require(:article).permit(:title, :description)


    end

end


# Helper for printing to console
def print_to_console(input)
    print "\n--------------------------------------------------\n"
    print "#{input}\n"
    print "--------------------------------------------------\n\n"
end