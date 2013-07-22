class PersistenceLayer
  def self.registry
    @registry ||= []
  end
  def initialize
    self.class.registry << self
  end
  def self.find(id)
    @registry.find {|obj| obj.to_param == Integer(id)}
  end

  def persisted?; true; end
  def to_param; object_id; end
end
