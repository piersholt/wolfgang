# frozen_string_literal: true

# Comment
module NotificationHandler
  include InterfaceConstants
  include NotificationDelegate

  attr_accessor :proc

  def handle(notification)
    if responsible?(notification)
      take_responsibility(notification)
    else
      forward(notification)
    end
  end

  private

  def responsibility
    raise(NaughtyHandler, self.class.name)
  end

  def responsible?(notification)
    notification.topic == responsibility
  end
end
