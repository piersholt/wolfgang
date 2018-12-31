# frozen_string_literal: true

module ObjectManagerHandler
  include InterfaceConstants
  # include SignalDelegate

  # attr_accessor :proc

  private

  def manages?(signal)
    responsibility.any? do |interface|
      signal.added_interfaces.include?(interface)
    end
  end
end
