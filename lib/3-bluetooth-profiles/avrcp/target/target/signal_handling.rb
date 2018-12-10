# frozen_string_literal: true

module AVRCP
  # Comment
  class Target
    # Comment
    module SignalHandling
      def target_control_callback
        proc do |signal|
          begin
            control_properties_changed(signal)
          rescue StandardError => e
            LOGGER.error('Properties') { e }
            e.backtrace.each { |line| LOGGER.error(line) }
          end
        end
      end

      def target_device_callback
        proc do |signal|
          begin
            device_properties_changed(signal)
          rescue StandardError => e
            LOGGER.error('Properties') { e }
            e.backtrace.each { |line| LOGGER.error(line) }
          end
        end
      end

      def target_device_call_callback
        proc do |signal|
          begin
            interface_called(signal)
          rescue StandardError => e
            LOGGER.error('Properties') { e }
            e.backtrace.each { |line| LOGGER.error(line) }
          end
        end
      end

      def player_callback
        proc do |signal|
          begin
            addressed_player.properties_changed(signal)
          rescue StandardError => e
            LOGGER.error('Properties') { e }
            e.backtrace.each { |line| LOGGER.error(line) }
          end
        end
      end

      def device_properties_changed(signal)
        if signal.only?('Connected') && signal.connected?
          device_connected
        elsif signal.only?('Connected') && signal.disconnected?
          device_disconnected
        end
      end

      def control_properties_changed(signal)
        if signal.connected? && signal.player?
          player_added(signal)
        elsif signal.player?
          player_changed(signal)
        elsif signal.disconnected? && signal.no_player?
          player_removed
        end
      end

      def interface_called(event)
        if event.method == :connect
          device_connecting
        elsif event.method == :disconnect
          device_disconnecting
        end
      end

      def player_added(signal)
        add_player(signal.player)
        LOGGER.unknown(self.class) { 'Player available!' }
        player_added!
        # player.track_changed!
      end

      def player_changed(signal)
        add_player(signal.player)
        LOGGER.unknown(self.class) { 'Player available!' }
        player_changed!
      end

      def player_removed
        LOGGER.unknown(self.class) { 'Player no longer available!' }
        remove_player
        player_removed!
      end

      def device_connecting
        LOGGER.unknown(self.class) { '#connect: Device connecting...' }
        device_connecting!
      end

      def device_disconnecting
        LOGGER.unknown(self.class) { '#disconnect: Device disconnecting...' }
        device_disconnecting!
      end

      def device_connected
        LOGGER.unknown(self.class) { 'Device connected!' }
        device_connected!
      end

      def device_disconnected
        LOGGER.unknown(self.class) { 'Device disconnected!' }
        device_disconnected!
      end
    end
  end
end