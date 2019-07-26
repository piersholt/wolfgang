# frozen_string_literal: true

module Wolfgang
  module Bluetooth
    module Profile
      module AVRCP
        class Controller
          module Notifications
            # Profile::AVRCP::Controller::Notifications::MediaControl
            module MediaControl
              include Constants

              def target_added!(signal)
                logger.info(MODULE_PROG) { PLAYER_ADDED }
                notification = Yabber::Notification.new(
                  topic: :target,
                  name: :added,
                  properties: { path: signal.path, **signal.changed }
                )
                notifications_queue.push(notification)
              end

              def target_updated!(signal)
                logger.info(MODULE_PROG) { PLAYER_CHANGED }
                notification = Yabber::Notification.new(
                  topic: :target,
                  name: :updated,
                  properties: { path: signal.path, **signal.changed }
                )
                notifications_queue.push(notification)
              end

              def target_removed!(signal)
                logger.info(MODULE_PROG) { PLAYER_REMOVED }
                notification = Yabber::Notification.new(
                  topic: :target,
                  name: :removed,
                  properties: { path: signal.path }
                )
                notifications_queue.push(notification)
              end
            end
          end
        end
      end
    end
  end
end
