# frozen_string_literal: true

module Messaging
  # Message constants
  module Constants
    # Message Types
    module Types
      NOTIFICATION = :notification
      ACTION = :action
      TYPES = %i[action notification].freeze
    end

    # Message Topics/Channels
    module Topics
      WILHELM = :wilhelm
      WOLFGANG = :wolfgang
      WALTER = :walter

      MEDIA = :media
      TEL = :tel

      DEVICE = :device
      TARGET = :target
      PLAYER = :player
      TRACK = :track

      TOPICS = [WILHELM, WOLFGANG, WALTER, MEDIA, TEL, DEVICE, TARGET, PLAYER, TRACK].freeze
    end

    # Notification Types
    module Notifications
      include Topics
      # Device
      CONNECTING = :connecting
      CONNECTED = :connected
      DISCONNECTING = :disconnecting
      DISCONNECTED = :disconnected

      # Player
      STATUS = { status: [:playing, :stopped, :paused, :forward_seek, :reverse_seek, :error] }.freeze
      REPEAT = { repeat: [:off, :single_track, :all_tracks, :group] }.freeze
      SHUFFLE = { shuffle: [:off, :all_tracks, :group] }.freeze

      # Track
      CHANGED = :changed
      STARTED = :started
      ENDED = :ended
      POSITION = :position

      NOTIFICATIONS = {
        DEVICE => [CONNECTING, CONNECTED, DISCONNECTING, DISCONNECTED],
        PLAYER => [STATUS, REPEAT, SHUFFLE],
        TRACK => [CHANGED, STARTED, ENDED, POSITION]
      }.freeze
    end

    # Action Types
    module Actions
      include Topics
      # Walter/Wolfgang
      HELLO = :hello

      # Device
      CONNECT = :connect
      DISCONNECT = :disconnect

      # Player
      PLAY = :play
      PAUSE = :pause
      STOP = :stop
      SEEK_NEXT = :seek_next
      SEEK_PREVIOUS = :seek_backward
      SCAN_FORWARD_START = :scan_forward_start
      SCAN_FORWARD_STOP = :scan_forward_stop
      SCAN_BACKWARD_START = :scan_backward_start
      SCAN_BACKWARD_STOP = :scan_backward_stop

      ACTIONS = {
        WALTER => [HELLO],
        WOLFGANG => [HELLO],
        DEVICE => [
          CONNECT, DISCONNECT
        ],
        PLAYER => [
          PLAY, PAUSE, STOP,
          SEEK_NEXT, SEEK_PREVIOUS,
          SCAN_FORWARD_START, SCAN_FORWARD_STOP,
          SCAN_BACKWARD_START, SCAN_BACKWARD_STOP
        ]
      }.freeze
    end

    include Types
    include Topics
    include Notifications
    include Actions
  end
end
