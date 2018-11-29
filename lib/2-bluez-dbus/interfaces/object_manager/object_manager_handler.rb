# frozen_string_literal: true

module ObjectManangerHandler
  include InterfaceConstants
  include ChainOfResponsibility

  attr_accessor :proc

  def handle(signal)
    if responsible?(signal)
      take_responsibility(signal)
    else
      forward(signal)
    end
  end

  private

  def responsibilities
    raise(NaughtyHandler, self.class.name)
  end

  def responsible?(signal)
    responsibilities.any? do |interface|
      signal.added_interfaces.include?(interface)
    end
  end
end
