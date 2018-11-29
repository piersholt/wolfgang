# frozen_string_literal: true

# TODO: rename Nepotistic!
module ChainOfResponsibility
  attr_accessor :successor
  # alias handle shirk

  def take_responsibility(signal = nil)
    raise(NaughtyHandler, self.class.name)
  end

  def forward(signal)
    raise(IfYouWantSomethingDone) unless successor
    successor.handle(signal)
  end
end
