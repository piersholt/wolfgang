# frozen_string_literal: true

module Wolfgang
  module AVRCP
    class Target
      # Commands
      module Commands
        extend Forwardable
        attr_accessor :commands_queue

        def_delegators :addressed_player, *BluezMediaPlayer.instance_methods
      end
    end
  end
end
