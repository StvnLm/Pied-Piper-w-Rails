class ProfilesController < ApplicationController
    # GET to /users/:user_id/profile/new
    def new
        # Render a blank profle details form
        @profile = Profile.new
    end
end