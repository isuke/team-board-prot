class ArticleLog < ActiveRecord::Base
  include LogOf

  log_of 'Article'
end
