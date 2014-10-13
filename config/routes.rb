Rails.application.routes.draw do

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
