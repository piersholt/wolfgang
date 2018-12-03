# frozen_string_literal: true

# TODO: rename Nepotistic!
module SignalDelegate
  include InterfaceConstants
  attr_accessor :successor
  # alias handle delegate_signal

  def handle(method, object)
    if responsible?(method, object)
      public_send(method, object)
    else
      forward(method, object)
    end
  end

  def forward(method, object)
    raise(IfYouWantSomethingDone) unless successor
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

  # VALIDATION
  def properties_changed(_ = nil)
    raise(NaughtyHandler, self.class.name)
  end

  def interface_called(_ = nil)
    raise(NaughtyHandler, self.class.name)
  end

  def interfaces_added(_ = nil)
    raise(NaughtyHandler, self.class.name)
  end

  def interfaces_removed(_ = nil)
    raise(NaughtyHandler, self.class.name)
  end

  def responsibility
    raise(NaughtyHandler, self.class.name)
  end
end

# Comment
module NotificationDelegate
  attr_accessor :successor
  # alias handle delegate_signal

  def handle(notification)
    if responsible?(notification)
      take_responsibility(notification)
    else
      forward(notification)
    end
  end

  def forward(signal)
    raise(IfYouWantSomethingDone) unless successor
    successor.handle(signal)
  end

  # VALIDATION
  def take_responsibility(signal = nil)
    raise(NaughtyHandler, self.class.name)
  end

  def responsibility
    raise(NaughtyHandler, self.class.name)
  end
end
