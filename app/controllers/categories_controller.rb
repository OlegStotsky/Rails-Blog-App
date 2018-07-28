class CategoriesController < ApplicationController
    before_action :require_admin, only: [:new, :create]
    
    def index 
        @categories = Category.paginate(page: params[:page], per_page: 3)
    end
    
    def show
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