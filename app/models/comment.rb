class Comment < ActiveRecord::Base

  belongs_to :article
  belongs_to :user

  validates :article          , presence: true
  validates :content          , presence: true
  validates :formatted_content, presence: true

  alias :old_user_method :user
  def user
    old_user_method || NullUser.instance
  end

end
