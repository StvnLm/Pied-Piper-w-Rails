# Blueprint of the contact obj

# Contact form validations
class Contact < ActiveRecord::Base
    validates :name, presence: true
    validates :email, presence: true
    validates :message, presence: true
end