# frozen_string_literal: true

# Comment
module NotificationDelegate
  include NotificationDelegateVaidation
  attr_accessor :successor

  def handle(notification)
    if responsible?(notification)
      LOGGER.debug(self.class) { "I am responsible for #{notification.name}!" }
      take_responsibility(notification)
    else
      LOGGER.debug(self.class) { "Not me! Forwarding: #{notification.name}" }
      forward(notification)
    end
  end

  def forward(notification)
    raise(IfYouWantSomethingDone, "No one to handle: #{notification}") unless successor
    successor.handle(notification)
  end

  def responsible?(notification)
    result = notification.topic == responsibility
    LOGGER.debug(self.class) { "#{notification.topic} == #{responsibility} => #{result}" }
    result
  end
end