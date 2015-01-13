Spree::Core::Engine.routes.draw do
	namespace :admin do
		resources :price_categories
	end
end
