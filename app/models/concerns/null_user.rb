class NullUser
  include Singleton
  def id; nil end
  def name; "Unkown" end
  def email; "Unkown" end
  def articles; [] end
  def comments; [] end
  def null_user?; true end
end
