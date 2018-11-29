# frozen_string_literal: true

module PropertiesHandler
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

  def responsibility
    raise(NaughtyHandler, self.class.name)
  end

  def responsible?(signal)
    signal.this_interface?(responsibility)
  end
end
