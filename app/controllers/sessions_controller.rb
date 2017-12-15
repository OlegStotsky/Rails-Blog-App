class SessionsController < ApplicationController
    def new
        
    end
    
    def create
        user = User.find_by(username: params[:session][:username].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:success] = 'You have successfuly logged in'
            @current_user = user
            redirect_to user_path(user)
        else
            flash.now[:danger] = "Log in failed. Wrong username or password"
            render 'new'
        end
    end
    
    def destroy
        session[:user_id] = nil
        flash[:success] = "You have logged out"
        redirect_to root_path
    end
end