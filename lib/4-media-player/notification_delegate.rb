# frozen_string_literal: true

# Comment
module NotificationDelegate
  attr_accessor :successor

  def handle(notification)
    if responsible?(notification)
      take_responsibility(notification)
    else
      forward(notification)
    end
  end

  def forward(signal)
    raise(IfYouWantSomethingDone, "No one to handle: #{signal}") unless successor
    successor.handle(signal)
  end

  # VALIDATION
  def take_responsibility(___ = nil)
    raise(NaughtyHandler, self.class.name)
  end

  def responsibility
    raise(NaughtyHandler, self.class.name)
  end
end
