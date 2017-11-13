class ArticlesController < ApplicationController
    def index
    end
    
    def create
        @article = Article.new(article_params)
        if @article.save
            flash[:notice] = "Article was successfuly created"
            redirect_to article_path(@article)
        else
            render 'new'
        end
    end
    
    def new
        @article = Article.new
    end
    
    def show
    end
    
    def edit
    end
    
    def update
    end
    
    def destroy
    end
    
    private
    def article_params
        params.require(:article).permit(:title, :description)
    end
end