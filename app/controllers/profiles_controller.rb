class ProfilesController < ApplicationController
    
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
            redirect_to user_path(params[:user_id])
        else
            render action: :new
        end
    end
    
    # Whitelisting form fields to be used    
    private
        def profile_params
            params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title,
            :phone_number, :contact_email, :description)
        end
        
end