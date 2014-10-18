class ArticleLog < ActiveRecord::Base
  include LogOf

  log_of 'Article'
  belongs_to :user
end
