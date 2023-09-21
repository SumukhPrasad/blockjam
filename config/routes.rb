Rails.application.routes.draw do
	devise_for :admin_users, ActiveAdmin::Devise.config
	devise_for :users
	# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

	# devise_for :admin_users, ActiveAdmin::Devise.config
	ActiveAdmin.routes(self)
	# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

	# Defines the root path route ("/")
	root :controller => 'index', :action => :index

	# Defines the root path route ("/")
	# root "articles#index"

	resources :heats, param: :slug do
		resources :questions, param: :question_number do
			post 'save_submission', to: 'submissions#save_submission'
		end
	end
end
