class Comment < ActiveRecord::Base

  belongs_to :article
  belongs_to :user

  validates :article, presence: true
  validates :user   , presence: true
  validates :content, presence: true
end
