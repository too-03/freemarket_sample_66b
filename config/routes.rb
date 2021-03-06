Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
  }
  root 'top#index'

  devise_scope :user do
    get   'addresses', to: 'users/registrations#new_address'
    post  'addresses', to: 'users/registrations#create_address'
  end
  resources :signup do
    collection do
      get 'done' #【新規会員登録】完了ページへ移動
    end
  end

  resources :users, only: [:index, :show] do
    resources :creditcards, only: [:new, :show] do
      collection do
        post 'show', to: 'creditcards#show'
        post 'pay', to: 'creditcards#pay'
        post 'delete', to: 'creditcards#delete'
      end
    end
  end
  
  resources :purchases, only: [:show] do
    collection do
      post 'pay/:id', to: 'purchases#pay', as: 'pay'
      get 'done', to: 'purchases#done'
    end
  end

  resources :top, except: :index
  resources :logouts, only: :index
  resources :items do
    collection do
      get 'delete_done', to: 'items#delete_done'
      get 'search', to: 'items#search'
      get 'grandchildren', to: 'items#grandchildren'
    end
  end
  # resources :products,only: [:index, :show, :edit, :destroy, :update]

  # get 'search_edit', to: 'products#search_edit'
  # get 'grandchildren_edit', to: 'products#grandchildren_edit'
end
