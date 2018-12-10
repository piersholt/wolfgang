# frozen_string_literal: true

module AVRCP
  # Comment
  class Player
    extend Forwardable
    include State
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
