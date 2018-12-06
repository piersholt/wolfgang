# frozen_string_literal: true

# Comment
class MediaPlayerInterfaceHandler
  include Singleton
  include SignalDelegate

  attr_accessor :mq

  # @override SignalDelegate
  def properties_changed(signal)
    if signal.only_track? && signal.title?
      track_change(signal)
    elsif signal.only_track?
      track_change(signal)
    elsif signal.only_position?
      position(signal)
    elsif signal.only_status?
      status(signal)
    elsif signal.only_repeat?
      repeat(signal)
    elsif signal.only_shuffle?
      shuffle(signal)
    end
  end

  private

  def track_change(signal)
    LOGGER.unknown(self.class) { "#{signal.title} by #{signal.artist}" }
    n = Messaging::Notification.new(topic: :media, name: :track_change, properties: signal.changed)
    mq.push(n)
  end

  def track_update(signal)
    LOGGER.unknown(self.class) { "#{signal.title} by #{signal.artist}" }
    n = Messaging::Notification.new(topic: :media, name: :track_update, properties: signal.changed)
    mq.push(n)
  end

  def position(signal)
    LOGGER.unknown(self.class) { time(signal.position) }
    n = Messaging::Notification.new(topic: :media, name: :position, properties: signal.changed)
    mq.push(n)
  end

  def status(signal)
    LOGGER.unknown(self.class) { signal.status }
    n = Messaging::Notification.new(topic: :media, name: :status, properties: signal.changed)
    mq.push(n)
  end

  def repeat(signal)
    LOGGER.unknown(self.class) { signal.repeat }
    n = Messaging::Notification.new(topic: :media, name: :repeat, properties: signal.changed)
    mq.push(n)
  end

  def shuffle(signal)
    LOGGER.unknown(self.class) { signal.shuffle }
    n = Messaging::Notification.new(topic: :media, name: :shuffle, properties: signal.changed)
    mq.push(n)
  end

  def responsibility
    BLUEZ_MEDIA_PLAYER
  end

  def time(milliseconds)
    seconds = milliseconds / 1000
    elapsed_time = seconds.divmod(60)
    elapsed_time.join(':')
  end
end
