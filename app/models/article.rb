class Article < ActiveRecord::Base
  include HasLogs

  has_logs [:title, :content, :user, :formatted_content],
           class_name: 'ArticleLog', dependent: :destroy
  belongs_to :user
  belongs_to :team
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :team, presence: true

  def create_user
    oldest_log.user
  end

  def edit_users
    logs.map(&:user)
  end

  def latest_edit_user
    latest_log.user
  end

end
