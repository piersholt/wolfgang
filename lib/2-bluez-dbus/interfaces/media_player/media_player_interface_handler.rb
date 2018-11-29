# frozen_string_literal: true

class MediaPlayerInterfaceHandler
  include Singleton
  include PropertiesHandler

  attr_accessor :mq

  ASSOCIATED_INTERFACE = BLUEZ_MEDIA_PLAYER

  def take_responsibility(signal)
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
    LOGGER.unknown('Media Not. (Track)') { "#{signal.title} by #{signal.artist}" }
    n = Notification.new(:track_change, delta: signal.changed)
    mq.push(n)
  end

  def position(signal)
    LOGGER.unknown('Media Not. (Time)') { time(signal.position) }
    n = Notification.new(:position)
    mq.push(n)
  end

  def status(signal)
    LOGGER.unknown('Media Not. (Playback)') { signal.status }
    n = Notification.new(:status)
    mq.push(n)
  end

  def repeat(signal)
    LOGGER.unknown('Media Not. (Repeat)') { signal.repeat }
    n = Notification.new(:repeat)
    mq.push(n)
  end

  def shuffle(signal)
    LOGGER.unknown('Media Not. (Shuffle)') { signal.shuffle }
    n = Notification.new(:shuffle)
    mq.push(n)
  end

  def responsibility
    ASSOCIATED_INTERFACE
  end

  def time(milliseconds)
    seconds = milliseconds / 1000
    elapsed_time = seconds.divmod(60)
    elapsed_time.join(':')
  end
end
