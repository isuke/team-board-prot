class Article < ActiveRecord::Base
  include HasLogs

  has_logs [:title, :content], class_name: 'ArticleLog', dependent: :destroy

  validates :title, presence: true
end
