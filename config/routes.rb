Rails.application.routes.draw do

  get 'teams_users/create'

  # static_pages
  match '/home', to: 'static_pages#home', via: 'get'

  # sessions
  resources :sessions, only: [:new, :create, :destroy]
  match '/login' , to: 'sessions#new'     , via: 'get'
  match '/logout', to: 'sessions#destroy' , via: 'delete'

  # users
  resources :users, only: [:new, :create, :show, :destroy]
  match '/signup', to: 'users#new', via: 'get'

  # teams
  resources :teams, only: [:index, :show, :create]
  post   'teams_users/:team_id/:user_id' => 'teams_users#create', as: :participate
  delete 'teams_users/:team_id/:user_id' => 'teams_users#destroy', as: :leave

  # articles
  scope :path => '/teams/:team_id' do
    resources :articles, only: [:show, :new, :create, :edit, :update, :destroy] do

      collection do
        resources :logs, controller: :article_logs, as: :article_logs,  only: [:show]
        get ':id1/:id2/diff' => 'article_logs#diff', as: :diff
        get 'diff'           => 'article_logs#diff'
      end

      member do
        resources :logs, controller: :article_logs, as: :article_logs, only: [:index]
        resources :comments, only: :create
      end
    end
  end


  root 'teams#index'

end
