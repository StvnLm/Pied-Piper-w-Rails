class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		 :recoverable, :rememberable, :trackable, :validatable
	# Each user belongs to a 1 plan, and has 1 profile
	belongs_to :plan
	has_one :profile
	# Whitelist form variable to be used
	attr_accessor :stripe_card_token
	# If Pro user passes validations (email, password, etc), then call Stripe and 
	# tell Stripe to set up a subscription upon charging the customers card token.
	# Stripe responds back /w customer data. We store customer.ida s the customer 
	# token and save the user.
	def save_with_subscription
		if valid?
		customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
		self.stripe_customer_token = customer.id
		save!
		end
	end
end
