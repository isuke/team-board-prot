Rails.application.routes.draw do

  resources :articles do
    collection do
      resources :article_logs, only: [:show, :new] do
        collection do
          get 'diff/:id1/:id2' => 'article_logs#diff', as: :diff
          get 'diff'           => 'article_logs#diff'
        end
      end
    end

    member do
      resources :article_logs, only: [:index]
    end
  end

  root 'articles#index'

end
