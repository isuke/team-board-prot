Rails.application.routes.draw do

  match '/home', to: 'static_pages#home', via: 'get'

  resources :sessions, only: [:new, :create, :destroy]
  match '/login' , to: 'sessions#new'     , via: 'get'
  match '/logout', to: 'sessions#destroy' , via: 'delete'


  resources :users, only: [:new, :create, :show, :destroy]
  match '/signup', to: 'users#new', via: 'get'

  resources :articles do

    collection do
      resources :logs, controller: :article_logs, as: :article_logs,  only: [:show]
      get ':id1/:id2/diff' => 'article_logs#diff', as: :diff
      get 'diff'           => 'article_logs#diff'
    end

    member do
      resources :logs, controller: :article_logs, as: :article_logs, only: [:index]
    end
  end

  root 'articles#index'

end
