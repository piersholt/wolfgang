# frozen_string_literal: true

# Comment
module Stateful
  def state
    @state ||= {}
  end

  private

  def squish(old, new)
    old.merge(new)
  end

  def state!(changes)
    state.merge!(changes) do |_, old, new|
      if old.instance_of?(Hash)
        squish(old, new)
      else
        new
      end
    end
  end
end

# Comment
class Player
  include Singleton
  extend Forwardable
  include Stateful

  attr_accessor :player_object
  def_delegators :player_object, *BluezMediaPlayer.instance_methods

  def to_s
    "#{title} by #{artist} from #{album}"
  end

  def update(delta)
    state!(delta)
  end

  def remove
    @player_object = nil
    @state = {}
  end

  def add_player(player_path)
    self.player_object = BluezDBus.service.player(player_path)
    # synchronise
  end

  def synchronise
    current = player_object.media_player.property_get_all
    update(current)
  end

  # Properties

  def title
    track.fetch('Title', '')
  end

  def album
    track.fetch('Album', '')
  end

  def artist
    track.fetch('Artist', '')
  end

  def track
    state['Track']
  end

  # Class Methods

  def self.add(player_path)
    instance.add_player(player_path)
  end

  def self.update(delta)
    instance.update(delta)
  end

  def self.remove
    instance.remove
  end
end
