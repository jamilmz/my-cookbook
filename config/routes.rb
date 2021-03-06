Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :recipes, only: [:index, :show, :new, :create, :edit, :update,
                             :destroy] do
    collection do
      get 'search'
      get 'my_recipes'
      get 'my_favorites'
    end

    member do
      post 'favorite'
      delete 'favorite', to: 'recipes#delete_favorite', as: 'delete_favorite'
      post 'share'
    end
  end
  resources :cuisines, only: [:index, :show, :new, :create, :edit, :update]
  resources :recipe_types, only: [:index, :show, :new, :create, :edit, :update]
end
