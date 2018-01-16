Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :recipes, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      get 'search'
      get 'my_recipes'
      get 'my_favorites'
    end

    member do
      post 'new_favorite'
      delete 'remove_favorite'
    end
  end
  resources :cuisines, only: [:show, :new, :create]
  resources :recipe_types, only: [:show, :new, :create]
end
