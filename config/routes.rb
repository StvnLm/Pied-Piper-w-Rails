# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
Rails.application.routes.draw do
	root to: 'pages#home'
	devise_for :users, controllers: { registrations: 'users/registrations' }
	get 'about', to: 'pages#about'
  # resources :contacts
  resources :contacts, only: :create
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
  get 'plans', to: 'pages#plans'
end