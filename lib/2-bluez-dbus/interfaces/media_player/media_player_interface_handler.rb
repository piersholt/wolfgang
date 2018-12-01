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
    LOGGER.unknown('MediaPlayer Handler') { "#{signal.title} by #{signal.artist}" }
    n = Notification.new(:media, :track_change, delta: signal.changed)
    mq.push(n)
  end

  def position(signal)
    LOGGER.unknown('MediaPlayer Handler') { time(signal.position) }
    n = Notification.new(:media, :position, delta: signal.changed)
    mq.push(n)
  end

  def status(signal)
    LOGGER.unknown('MediaPlayer Handler') { signal.status }
    n = Notification.new(:media, :status, delta: signal.changed)
    mq.push(n)
  end

  def repeat(signal)
    LOGGER.unknown('MediaPlayer Handler') { signal.repeat }
    n = Notification.new(:media, :repeat, delta: signal.changed)
    mq.push(n)
  end

  def shuffle(signal)
    LOGGER.unknown('MediaPlayer Handler') { signal.shuffle }
    n = Notification.new(:media, :shuffle, delta: signal.changed)
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
