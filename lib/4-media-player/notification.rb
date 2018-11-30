# frozen_string_literal: true

# Comment
class Notification
  attr_reader :type, :options

  def initialize(type, options = {})
    @type = type
    @options = options
  end

  def to_s
    "Notification: #{type}!"
  end
end
