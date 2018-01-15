class PagesController < ApplicationController
    # GET request for / (home)
    def home
    end
    
    def plans
    # Instance variables are defined in controller and then can be used in views
        @basic_plan = Plan.find(1)
        @pro_plan = Plan.find(2)
    end
    
    def about
    end
end