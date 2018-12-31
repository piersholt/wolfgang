# frozen_string_literal: true

# Comment
class MediaPlayerInterfaceHandler
  include Singleton
  include SignalDelegate

  # attr_accessor :mq
  # attr_accessor :target
  attr_accessor :callback

  def responsibility
    BLUEZ_MEDIA_PLAYER
  end

  # @override SignalDelegate
  def properties_changed(signal)
    LogActually.player.debug('MediaPlayerInterfaceHandler') { '#properties_changed' }
    callback.call(signal)
    # interrogate(signal)
  end


  # def interrogate(signal)
  #   if signal.only_track? && signal.title?
  #     track_change(signal)
  #   elsif signal.duration? && !signal.title?
  #     duration(signal)
  #   elsif signal.only_position?
  #     position(signal)
  #   elsif signal.only_status?
  #     status(signal)
  #   elsif signal.only_repeat?
  #     repeat(signal)
  #   elsif signal.only_shuffle?
  #     shuffle(signal)
  #   end
  # end

  # private

  # Track change events
  # Change of track
  # Start of track
  # End of track

  # ^ there is definitely three events

  # Playback position in milliseconds. When position is 0 it means
  # the track is starting and when it's greater than or
  # equal to track's duration the track has ended. Note
  # that even if duration is not available in metadata it's
  # possible to signal its end by setting position to the
  # maximum uint32 value.

  # def track_change(signal)
  #   LOGGER.unknown(self.class) { "Track change!" }
  #   n = Messaging::Notification.new(topic: :player, name: :track_change, properties: signal.changed)
  #   mq.push(n)
  #   addressed_player.attributes!(signal.changed)
  # end
  #
  # def duration(signal)
  #   LOGGER.unknown(self.class) { "Duration: #{signal.changed}" }
  #   n = Messaging::Notification.new(topic: :player, name: :track_duration, properties: signal.changed)
  #   mq.push(n)
  #   addressed_player.attributes!(signal.changed)
  # end
  #
  # def position(signal)
  #   # puts signal.position <= 1500
  #   # puts signal.position > addressed_player.duration
  #   event =
  #     if signal.position <= 1500
  #       :track_start
  #     elsif (signal.position - addressed_player.duration) <= 1500
  #       :track_end
  #     else
  #       :position
  #     end
  #   LOGGER.unknown(self.class) { "#{event}!" }
  #   n = Messaging::Notification.new(topic: :player, name: event, properties: signal.changed)
  #   mq.push(n)
  #   addressed_player.attributes!(signal.changed)
  # end
  #
  # def status(signal)
  #   LOGGER.unknown(self.class) { signal.status }
  #   n = Messaging::Notification.new(topic: :player, name: :status, properties: signal.changed)
  #   mq.push(n)
  #   addressed_player.attributes!(signal.changed)
  # end
  #
  # def repeat(signal)
  #   LOGGER.unknown(self.class) { signal.repeat }
  #   n = Messaging::Notification.new(topic: :player, name: :repeat, properties: signal.changed)
  #   mq.push(n)
  #   addressed_player.attributes!(signal.changed)
  # end
  #
  # def shuffle(signal)
  #   LOGGER.unknown(self.class) { signal.shuffle }
  #   n = Messaging::Notification.new(topic: :player, name: :shuffle, properties: signal.changed)
  #   mq.push(n)
  #   addressed_player.attributes!(signal.changed)
  # end


  # def addressed_player
  #   target.addressed_player
  # end

  # def time(milliseconds)
  #   seconds = milliseconds / 1000
  #   elapsed_time = seconds.divmod(60)
  #   elapsed_time.join(':')
  # end
end
