class SelfDependencyError < StandardError
  def initialize(msg="Jobs can't depend on themselves.")
    super
  end
end

class CircularDependencyError < StandardError
  def initialize(msg="Jobs can’t have circular dependencies.")
    super
  end
end