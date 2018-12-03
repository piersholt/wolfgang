# frozen_string_literal: true

module PropertiesHandler
  include InterfaceConstants
  include SignalDelegate

  attr_accessor :proc

  private

  def relates_to?(object)
    object.this_interface?(responsibility)
  end
end
