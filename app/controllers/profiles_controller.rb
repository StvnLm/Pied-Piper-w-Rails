class ProfilesController < ApplicationController
    
    # Before any action on page, use devise GEM for authnetication
    before_action :authenticate_user!
    before_action :only_current_user
    
    # GET to /users/:user_id/profile/new
    def new
        # Render a blank profle details form
        @profile = Profile.new
    end
    
    # POST to /users/:user_id/profile 
    def create
        # Ensure we have the user who is filling out form
        @user = User.find(params[:user_id])
        # Create profile linked to specific user
        @profile = @user.build_profile(profile_params)
        if @profile.save
            flash[:success] = "Profile updated!"
            redirect_to user_path(id: params[:user_id])
        else
            render action: :new
        end
    end
    
    # GET for /users/:user_id/profile/edit
    def edit
        @user = User.find(params[:user_id])
        @profile = @user.profile
    end
    
    # PUT/PATCH request to /users/:user_id/profile 
    def update
        # Retrieve user from the DB
        @user = User.find(params[:user_id])
        # Retreive the users profile
        @profile = @user.profile
        # Edited profile attributes and save
        if @profile.update_attributes(profile_params)
            flash[:success] = "Profile updated!"
            # Redirect user to profile page
            redirect_to user_path(params[:user_id])
        else
            render action :edit
        end
    end

    # Priv functions, dont need to be called outside file; only within this file   
    private
        # Whitelisting form fields to be used 
        def profile_params
            params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title,
            :phone_number, :contact_email, :description)
        end
        
        # Function to only allow the current user to edit their own pages
        def only_current_user
            # Find the current user, and redirect to root unless the user matches 
            # the devise GEM current_user
            @user = User.find(params[:user_id])
            redirect_to(root_path) unless @user == current_user
        end
end