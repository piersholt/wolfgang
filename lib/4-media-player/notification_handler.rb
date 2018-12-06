# frozen_string_literal: true

# Comment
module NotificationHandler
  include InterfaceConstants
  include NotificationDelegate

  attr_accessor :proc

  private

  def responsibility
    raise(NaughtyHandler, self.class.name)
  end

  def responsible?(notification)
    notification.topic == responsibility
  end
end
