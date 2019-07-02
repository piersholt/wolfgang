# frozen_string_literal: true

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

  def this_interface?(interface)
    target == interface
  end

  def fetch(property_name)
    changed[property_name]
  end

  def has?(property_name)
    return false unless changed.key?(property_name)
    true
  end

  def only?(property_name)
    return false unless changes?(1) && has?(property_name)
    true
  end

  def changes
    changed.size
  end

  def changes?(count = 1)
    changes == count
  end

  def removals
    removed.size
  end

  def removals?(count = 1)
    removals == count
  end

  def is?(property, value)
    return false unless changed.key?(property)
    changed[property] == value
  end

  def less?(property, value)
    return false unless changed.key?(property)
    changed[property] < value
  end

  def removed?(property_name)
    removed.include?(property_name)
  end
end
