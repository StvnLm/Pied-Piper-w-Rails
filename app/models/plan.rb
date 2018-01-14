class Plan < ActiveRecord::Base
    # Plan has many users
    has_many :users
    
end    