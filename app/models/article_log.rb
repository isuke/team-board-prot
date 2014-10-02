class ArticleLog < ActiveRecord::Base
  belongs_to :article, touch: true

  validates :article_id, presence: true,
                         uniqueness: { scope: :created_at }
  validates :title     , presence: true

  def next
    self.article.logs.where("created_at > ?", self.created_at).order(:created_at).first
  end

  def prev
    self.article.logs.where("created_at < ?", self.created_at).order(:created_at).last
  end
end
