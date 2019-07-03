# frozen_string_literal: true

module Wolfgang
  module AVRCP
    class Target
      # SignalHandling
      module SignalHandling
        def target_control_callback
          proc do |signal|
            begin
              control_properties_changed(signal)
            rescue StandardError => e
              LogActually.avrcp.error('Properties') { e }
              e.backtrace.each { |line| LogActually.avrcp.error(line) }
            end
          end
        end

        def player_callback
          proc do |signal|
            begin
              addressed_player.properties_changed(signal)
            rescue StandardError => e
              LogActually.avrcp.error('Properties') { e }
              e.backtrace.each { |line| LogActually.avrcp.error(line) }
            end
          end
        end

        # --------------------------------------------------------------------- #

        # def device_properties_changed(signal)
        #   LogActually.avrcp.debug(self.class.name) { 'device_properties_changed!' }
        #   if signal.only?('Connected') && signal.connected?
        #     device_connected
        #   elsif signal.only?('Connected') && signal.disconnected?
        #     device_disconnected
        #   elsif signal.connected?
        #     # LogActually.device.debug(self.class.name) { '' }
        #     device_connected
        #   elsif signal.disconnected?
        #     # LogActually.device.debug(self.class.name) { 'existing disconnected!' }
        #     # device_disconnected
        #   end
        # end

        def control_properties_changed(signal)
          LogActually.avrcp.debug(self.class.name) { 'media_control_properties_changed!' }
          if signal.connected? && signal.player?
            player_added(signal)
          elsif signal.player?
            player_changed(signal)
          elsif signal.disconnected? && signal.no_player?
            player_removed
          end
        end

        # def interface_called(event)
        #   LogActually.avrcp.debug(self.class.name) { 'interface_called!' }
        #   if event.method == :connect
        #     device_connecting
        #   elsif event.method == :disconnect
        #     device_disconnecting
        #   end
        # end

        def player_added(signal)
          LogActually.avrcp.debug(self.class) { 'Player available!' }
          add_player(signal.player)
          player_added!
          # player.track_changed!
        end

        def player_changed(signal)
          LogActually.avrcp.debug(self.class) { 'Player changed!' }
          add_player(signal.player)
          player_changed!
        end

        def player_removed
          LogActually.avrcp.debug(self.class) { 'Player removed!' }
          remove_player
          player_removed!
        end

        # def device_connecting
        #   LogActually.avrcp.debug(self.class) { '#connect: Device connecting...' }
        #   device_connecting!
        # end
        #
        # def device_disconnecting
        #   LogActually.avrcp.debug(self.class) { '#disconnect: Device disconnecting...' }
        #   device_disconnecting!
        # end
        #
        # def device_connected
        #   LogActually.avrcp.debug(self.class) { 'Device connected!' }
        #   device_connected!
        # end
        #
        # def device_disconnected
        #   LogActually.avrcp.debug(self.class) { 'Device disconnected!' }
        #   device_disconnected!
        # end
      end
    end
  end
end
