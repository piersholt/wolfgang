# frozen_string_literal: true

module Wolfgang
  module AVRCP
    class Target
      # Notifications
      module Notifications
        attr_accessor :notifications_queue

        # def everyone!
        #   LogActually.avrcp.info('Notificaion') { "Everyone!" }
        #   n = Messaging::Notification.new(topic: :player, name: :everyone, properties: addressed_player.attributes)
        #   notifications_queue.push(n)
        #   # changed!
        # end

        def player_added!
          LogActually.avrcp.info('Notification') { 'Player added!' }
          n = Messaging::Notification.new(topic: :target, name: :player_added, properties: addressed_player.object.path)
          notifications_queue.push(n)
        end

        def player_changed!
          LogActually.avrcp.info('Notification') { 'Player changed!!' }
          n = Messaging::Notification.new(topic: :target, name: :player_changed, properties: addressed_player.object.path)
          notifications_queue.push(n)
        end

        def player_removed!
          LogActually.avrcp.info('Notification') { 'Player removed!' }
          n = Messaging::Notification.new(topic: :target, name: :player_removed)
          notifications_queue.push(n)
        end
      end
    end
  end
end
