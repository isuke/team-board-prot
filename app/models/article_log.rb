class ArticleLog < ActiveRecord::Base
  belongs_to :article, touch: true

  validates :article_id, presence: true,
                         uniqueness: { scope: :created_at }
  validates :title     , presence: true

  after_save :update_article

  private

  def update_article
    self.article.touch
  end
end
