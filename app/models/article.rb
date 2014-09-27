class Article < ActiveRecord::Base
  has_many :logs, class_name: "ArticleLog"

  def latest_log
    logs.order("created_at DESC").first
  end

  def method_missing(method, *args)
    self.latest_log.send(method, *args)
  end
end
