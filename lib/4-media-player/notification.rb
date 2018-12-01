# frozen_string_literal: true

# Comment
class Notification
  attr_reader :type, :name, :options

  def initialize(type, name, options = {})
    @type = type
    @name = name
    @options = options
  end

  def to_s
    "Notification: #{type}!"
  end
end
