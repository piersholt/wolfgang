# frozen_string_literal: true

module Wolfgang
  module Bluetooth
    module Profile
      module AVRCP
        class Controller
          module Notifications
            # Profile::AVRCP::Controller::Notifications::MediaPlayer
            module MediaPlayer
              include Constants

              def media_player_changed!(signal)
                logger.debug(MODULE_PROG) { '#media_player_changed!' }
                logger.info(MODULE_PROG) { PLAYER_CHANGED }
                logger.info(MODULE_PROG) { "signal.path => #{signal.path}" }
                logger.info(MODULE_PROG) { "signal.removed => #{signal.removed}" }
                logger.info(MODULE_PROG) { "signal.changed => #{signal.changed}" }
                # logger.info(MODULE_PROG) { "device => #{device}" }
                n = Yabber::Notification.new(
                  topic: :player,
                  name: :updated,
                  properties: { path: signal.path, **signal.changed }
                )
                notifications_queue.push(n)
              end

              def track_start!(signal)
                logger.debug(MODULE_PROG) { '#track_start!' }

                n = Yabber::Notification.new(
                  topic: :player,
                  name: :track_start,
                  properties: { path: signal.path, **signal.changed }
                )
                notifications_queue.push(n)
              end

              def track_change!(signal)
                logger.debug(MODULE_PROG) { '#track_change!' }

                n = Yabber::Notification.new(
                  topic: :player,
                  name: :track_change,
                  properties: { path: signal.path, **signal.changed }
                )
                notifications_queue.push(n)
              end

              def notify!(event, signal)
                logger.debug(MODULE_PROG) { "##{event}!" }

                n = Yabber::Notification.new(
                  topic: :player,
                  name: event,
                  properties: { path: signal.path, **signal.changed }
                )
                notifications_queue.push(n)
              end
            end
          end
        end
      end
    end
  end
end
