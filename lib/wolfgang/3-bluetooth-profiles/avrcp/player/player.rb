# frozen_string_literal: true

require_relative 'constants'
require_relative 'attributes'
require_relative 'notifications'
require_relative 'signal_handling'

module Wolfgang
  module AVRCP
    # Player
    class Player
      extend Forwardable
      include Attributes
      include SignalHandling
      include Notifications

      def_delegators :object, *BluezMediaPlayer::Methods.instance_methods

      attr_reader :object

      def initialize(player_path)
        @object = BluezDBus.service.player(player_path)
      end
    end
  end
end
