class Profile < ActiveRecord::Base
    # Each profile will belong to 1 users
    belongs_to :user
end