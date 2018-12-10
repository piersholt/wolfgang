# frozen_string_literal: true

# Comment
class VirtualCarKit
  attr_reader :media_controller

  def initialize
    @media_controller = MediaController.new
    # notify
  end

  # def notify
  #   n = Messaging::Notification.new(topic: :meta, name: :publisher_start)
  #   Publisher.send(n.topic, n.to_yaml)
  # end

  def run
    @media_controller.start
  end
end
