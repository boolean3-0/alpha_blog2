class ArticlesController < ApplicationController
    def new
        # Create a new instance of Article, our model class for the 
        # articles table. This instance variable is then available in
        # our view for the new action (i.e., in the new.html.erb file).
        # For more details about this Rails magic:
        # https://stackoverflow.com/questions/18773172/rails-how-do-controllers-pass-instance-variables-to-views-can-it-be-stopped/18774043
        # https://medium.com/@eric.programmer/removing-the-hack-in-rails-controllers-52396463c40d
        @article = Article.new

        # print "\n------------------------------------------------\n"
        # print "INSIDE ArticlesController, new method\n"
        # print "@article: #{@article}\n"
        # print "@article.class: #{@article.class}\n"
        # print "--------------------------------------------------\n"

    end

    # The create method automatically receives params from the form submission.
    # (The form is contained in new.html.erb.)
    def create

        # The line below lets us see params[:article].
        # I added parentheses to make it easier to read, but it can also
        # be written as "render plain: params[:article].inspect".
        # Note: params is actually an object, not a Ruby Hash!
        # See: https://eileencodes.com/posts/actioncontroller-parameters-now-returns-an-object-instead-of-a-hash/
        # render(plain: (params[:article].inspect))

        # As proven by the code below, Rails throws away instances of
        # ArticlesController (this class) after calling a single instance method.
        # print "\n------------------------------------------------\n"
        # print "INSIDE ArticlesController, create method\n"
        # print "@article: #{@article}\n" #=> (blank)
        # print "@article.class: #{@article.class}\n" #=> NilClass
        # print "--------------------------------------------------\n"
        
        # Create new article
        @article = Article.new(article_params)

        # Add article to database
        @article.save

        # Redirect to the show action. We must include @article
        # as an argument because the show action requires an article
        # id as part of its URL. (Run "rails routes" to see this.)
        redirect_to articles_show(@article)

    end

    private
    def article_params

        # print "\n--------------------------------------------------\n"
        # print "params: #{params}\n\n"
        # print "params.require(:article): #{params.require(:article)}\n\n"
        # print "params.require(:article).permit(:title, :description):
        # #{params.require(:article).permit(:title, :description)}\n\n"
        # print "--------------------------------------------------\n\n"


        params.require(:article).permit(:title, :description)


    end

end