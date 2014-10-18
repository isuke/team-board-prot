module HasLogs
  extend ActiveSupport::Concern

  @attrs = {}

  cattr_accessor :attrs

  module ClassMethods
    def has_logs(attrs, *args)
      HasLogs.attrs = attrs

      has_many :logs, *args

      HasLogs.attrs.each do |attr|
        attr_accessor attr
      end

      after_find   :set_attrs
      after_create :create_log
      after_update :create_log
    end
  end

  def latest_log
    logs.order(:created_at).last
  end

  def oldest_log
    logs.order(:created_at).first
  end

  def create_log
    values = {}
    HasLogs.attrs.each do |attr|
      values[attr] = send(attr)
    end
    logs.build(values).save
  end

  def set_attrs
    HasLogs.attrs.each do |attr|
      self.send("#{attr}=", latest_log.try(:"#{attr}"))
    end
  end

end
