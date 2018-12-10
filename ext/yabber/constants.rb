# frozen_string_literal: true

module Messaging
  # Message constants
  module Constants
    # Message Types
    NOTIFICATION = :notification
    ACTION = :action
    TYPES = %i[action notification].freeze

    # Message Topics/Channels
    MEDIA = :media
    TEL = :tel

    META = :meta

    DEVICE = :device
    TARGET = :target
    PLAYER = :player
    TOPICS = [META, MEDIA, TEL, DEVICE, TARGET, PLAYER].freeze
  end
end
