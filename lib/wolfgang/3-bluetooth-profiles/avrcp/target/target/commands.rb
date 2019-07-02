# frozen_string_literal: true

module AVRCP
  class Target
    # Comment
    module Commands
      extend Forwardable
      attr_accessor :commands_queue

      def_delegators :addressed_player, *BluezMediaPlayer.instance_methods
    end
  end
end
