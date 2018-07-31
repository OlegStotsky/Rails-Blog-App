class CategoriesController < ApplicationController
    before_action :require_admin, only: [:new, :create]
    
    def index 
        @categories = Category.paginate(page: params[:page], per_page: 3)
    end
    
    def show
        @category = Category.find(params[:id])
        @articles = @category.articles
    end
    
    def new
        @category = Category.new
    end
    
    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:success] = "Successfully created new category"
            redirect_to categories_path
        else
            render 'new'
        end
    end
    
    def edit
        @category = Category.find(params[:id])
    end
    
    def update
        @category = Category.find(params[:id])
        if @category.update(category_params)
            flash[:success] = "Successfuly updated category #{@category.name}"
            redirect_to categories_path
        else
            render 'edit'
        end
    end
    
    private
    def category_params
        params.require(:category).permit(:name)
    end
    
    def require_admin
        if !logged_in? || !current_user.admin?
            flash[:danger] = "Only admin is permited to create new categories"
            redirect_to categories_path
        end
    end
end