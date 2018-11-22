class PropertiesChanged < BaseSignal
  attr_reader :target, :changed, :removed

  def initialize(object, target, changed, removed)
    super(path: object,
          interface: Properties::PROPERTIES,
          member:   'PropertiesChanged')
    @target = target
    @changed = changed
    @removed = removed
  end
end
