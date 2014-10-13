module LogOf
  extend ActiveSupport::Concern

  module ClassMethods
    def log_of(name)
      belongs_to :originator, class_name: name, foreign_key: "#{name.downcase}_id", touch: true

      validates :"#{name.downcase}_id", presence: true, uniqueness: { scope: :created_at }
    end
  end

  def next
    originator.logs.where("created_at > ?", self.created_at).order(:created_at).first
  end

  def prev
    originator.logs.where("created_at < ?", self.created_at).order(:created_at).last
  end

end
