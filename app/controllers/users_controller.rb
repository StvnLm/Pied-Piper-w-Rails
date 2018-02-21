class UsersController < ApplicationController
    
    # Authenticate user with Devise GEM before any actions to secure user pages
    before_action :authenticate_user!
    
    # GET to /users/:id
    def show
        @user = User.find(params[:id])
    end
end
