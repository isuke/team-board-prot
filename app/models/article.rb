class Article < ActiveRecord::Base
  has_many :logs, class_name: "ArticleLog", dependent: :destroy

  def latest_log
    logs.order(:created_at).last
  end

  def method_missing(method, *args)
    self.latest_log.send(method, *args)
  end
end
