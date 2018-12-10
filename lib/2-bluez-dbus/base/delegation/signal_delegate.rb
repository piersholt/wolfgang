# frozen_string_literal: true

# Comment
module SignalDelegate
  include InterfaceConstants
  include SignalDelegateValidation
  attr_accessor :successor

  def handle(method, object)
    LOGGER.debug(self.class) { "#handle(#{method}, #{object})" }
    if responsible?(method, object)
      LOGGER.debug(self.class) { "I am responsible!" }
      public_send(method, object)
    else
      LOGGER.debug(self.class) { "Not me! Forwarding!" }
      forward(method, object)
    end
  end

  def forward(method, object)
    raise(IfYouWantSomethingDone, "No one to handle: #{method}, #{object}") unless successor
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

  def affected_by?(object)
    responsibility.any? do |interface|
      object.added_interfaces.include?(interface)
    end
  end

  def relates_to?(object)
    LOGGER.debug(self.class) { "#relates_to?(#{object.class}/#{object.target})" }
    result = object.this_interface?(responsibility)
    LOGGER.debug(self.class) { "#{object.target} == #{responsibility} => #{result}" }
    result
  end
end
