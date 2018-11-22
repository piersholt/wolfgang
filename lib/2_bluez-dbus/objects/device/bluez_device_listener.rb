# frozen_string_literal: true
class BluezDeviceListener < BaseSignalListener
  include Singleton
  PROC = 'Device'

  # def initialize(handler)
  #   @handler = handler
  # end

  def new_device(device)
    device.properties
          .properties_changed(
            self,
            :properties_changed,
            DevicePropertiesChanged
          )
  end

  def properties_changed(signal)
    begin
      self.proc = 'PropertiesChanged'
      super(signal)
      if signal.media?
        check_player(signal)
      elsif signal.device_changes?
        # check_connection(signal)
      end
    rescue StandardError => e
      LOGGER.error(proc) { e }
      e.backtrace.each { |line| LOGGER.error(line) }
    end
  end

  def available_device(device)
  end

  private

  def check_player(signal)
    LOGGER.warn('Services') { signal.player } if signal.player?
  end

  def check_connection(signal)
    return false unless signal.connected?
    device_path = signal.path
    # device = BluezDBus.service.device(device_path)
    @handler.target(device_path)
    service_classes = @handler.service_classes
    service_classes.each do |service|
      LOGGER.info('Service Available') { service }
    end
  end
end
