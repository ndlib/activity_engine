class PersistenceLayer
  def self.registry
    @registry ||= []
  end
  def initialize
    self.class.registry << self
  end
  def self.find(id)
    @registry.find {|obj| obj.to_key == Array(id)}
  end

  def persisted?; true; end
  def to_param; String(object_id); end
  def to_key; [String(object_id)]; end
end
