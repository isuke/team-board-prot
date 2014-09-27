Rails.application.routes.draw do

  resources :articles do
    resources :article_logs, only: [:index, :show], as: :logs
  end

  root 'articles#index'

end
