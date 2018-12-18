# frozen_string_literal: true

module Messaging
  # Message constants
  module Constants
    # Message Types
    NOTIFICATION = :notification
    ACTION = :action
    TYPES = %i[action notification].freeze

    # Message Topics/Channels
    # YABBER = :system

    MEDIA = :media
    TEL = :tel

    # META = :meta

    SYSTEM = :system

    DEVICE = :device
    TARGET = :target
    PLAYER = :player

    TOPICS = [SYSTEM, MEDIA, TEL, DEVICE, TARGET, PLAYER].freeze
  end
end
