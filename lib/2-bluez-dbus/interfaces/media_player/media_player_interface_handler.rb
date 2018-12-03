# frozen_string_literal: true

class MediaPlayerInterfaceHandler
  include Singleton
  include SignalDelegate

  attr_accessor :mq

  def properties_changed(signal)
    if signal.only_track?
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
    n = Notification.new(:media, :track_change, delta: signal.changed)
    mq.push(n)
  end

  def position(signal)
    LOGGER.unknown(self.class) { time(signal.position) }
    n = Notification.new(:media, :position, delta: signal.changed)
    mq.push(n)
  end

  def status(signal)
    LOGGER.unknown(self.class) { signal.status }
    n = Notification.new(:media, :status, delta: signal.changed)
    mq.push(n)
  end

  def repeat(signal)
    LOGGER.unknown(self.class) { signal.repeat }
    n = Notification.new(:media, :repeat, delta: signal.changed)
    mq.push(n)
  end

  def shuffle(signal)
    LOGGER.unknown(self.class) { signal.shuffle }
    n = Notification.new(:media, :shuffle, delta: signal.changed)
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
