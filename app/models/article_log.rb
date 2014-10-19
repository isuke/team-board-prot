class ArticleLog < ActiveRecord::Base
  include LogOf

  log_of 'Article'
  belongs_to :user

  alias :old_user_method :user
  def user
    old_user_method || NullUser.instance
  end

end
