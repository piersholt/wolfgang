# frozen_string_literal: true

require_relative 'constants'
require_relative 'attributes'
require_relative 'notifications'
require_relative 'signal_handling'

module Wolfgang
  module AVRCP
    # Target
    class Target
      extend Forwardable
      include Attributes
      include SignalHandling
      include Notifications

      attr_reader :addressed_player, :browsed_player,
      :battery_status, :system_status, :volume

      attr_accessor :commands_queue

      def_delegators :addressed_player, *BluezMediaPlayer.instance_methods

      PROG = 'AVRCP::Target'

      alias player addressed_player

      def initialize
        @addressed_player = nil
        @browsed_player = nil

        @battery_status = nil
        @system_status = nil

        @volume = 50
      end

      def add_player(player_path)
        LogActually.avrcp.debug(PROG) { "#add_player(#{player_path})" }
        new_player = Player.new(player_path)
        new_player.notifications_queue = notifications_queue
        @addressed_player = new_player
      end

      def remove_player
        @addressed_player = nil
      end
    end
  end
end
