# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
Rails.application.routes.draw do
  devise_for :users
	root to: 'pages#home'
	get 'about', to: 'pages#about'
  # resources :contacts
  resources :contacts, only: :create
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
  get 'plans', to: 'pages#plans'
end