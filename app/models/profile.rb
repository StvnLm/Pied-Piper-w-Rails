class Profile < ActiveRecord::Base
    # Each profile will belong to 1 users
    belongs_to :user
    
    has_attached_file :avatar,
                      :styles => {:medium => "300x300>", :thumb => "100x100>"},
                      :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end