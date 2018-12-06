# frozen_string_literal: true

module Messaging
  # Message constants
  module Constants
    NOTIFICATION = :notification
    ACTION = :action
    TYPES = %i[action notification].freeze

    MEDIA = :media
    TEL = :tel
    DEVICE = :device
    TOPICS = [MEDIA, TEL, DEVICE].freeze
  end
end
