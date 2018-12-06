# frozen_string_literal: true

module SignalDelegate
  include InterfaceConstants
  include SignalDelegateValidation
  attr_accessor :successor

  def handle(method, object)
    if responsible?(method, object)
      public_send(method, object)
    else
      forward(method, object)
    end
  end

  def forward(method, object)
    raise(IfYouWantSomethingDone, "No one to handle: #{signal}") unless successor
    successor.handle(method, object)
  end

  def responsible?(method, object)
    case method
    when :properties_changed
      respond_to?(:properties_changed) && relates_to?(object)
    when :interfaces_added
      respond_to?(:interfaces_added) && affected_by?(object)
    when :interfaces_removed
      respond_to?(:interfaces_removed) && affected_by?(object)
    when :interface_called
      respond_to?(:interface_called) && relates_to?(object)
    else
      false
    end
  end

  def affected_by?(signal)
    responsibility.any? do |interface|
      signal.added_interfaces.include?(interface)
    end
  end

  def relates_to?(signal)
    signal.this_interface?(responsibility)
  end
end
