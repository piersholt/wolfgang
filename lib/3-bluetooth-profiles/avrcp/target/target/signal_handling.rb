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
            LogActually.target.error('Properties') { e }
            e.backtrace.each { |line| LogActually.target.error(line) }
          end
        end
      end

      def target_device_callback
        proc do |signal|
          begin
            device_properties_changed(signal)
          rescue StandardError => e
            LogActually.target.error('Properties') { e }
            e.backtrace.each { |line| LogActually.target.error(line) }
          end
        end
      end

      def target_device_call_callback
        proc do |signal|
          begin
            interface_called(signal)
          rescue StandardError => e
            LogActually.target.error('Properties') { e }
            e.backtrace.each { |line| LogActually.target.error(line) }
          end
        end
      end

      def player_callback
        proc do |signal|
          begin
            addressed_player.properties_changed(signal)
          rescue StandardError => e
            LogActually.target.error('Properties') { e }
            e.backtrace.each { |line| LogActually.target.error(line) }
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
        LogActually.target.unknown(self.class) { 'Player available!' }
        player_added!
        # player.track_changed!
      end

      def player_changed(signal)
        add_player(signal.player)
        LogActually.target.unknown(self.class) { 'Player changed!' }
        player_changed!
      end

      def player_removed
        LogActually.target.unknown(self.class) { 'Player removed!' }
        remove_player
        player_removed!
      end

      def device_connecting
        LogActually.target.unknown(self.class) { '#connect: Device connecting...' }
        device_connecting!
      end

      def device_disconnecting
        LogActually.target.unknown(self.class) { '#disconnect: Device disconnecting...' }
        device_disconnecting!
      end

      def device_connected
        LogActually.target.unknown(self.class) { 'Device connected!' }
        device_connected!
      end

      def device_disconnected
        LogActually.target.unknown(self.class) { 'Device disconnected!' }
        device_disconnected!
      end
    end
  end
end
