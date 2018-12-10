# frozen_string_literal: true

# Comment
class VirtualCarKit
  attr_reader :controller

  def initialize
    @controller = Controller.new
  end

  def run
    controller.start
  end
end
