# frozen_string_literal: true

module AVRCP
  class Target
    # Comment
    module Notifications
      attr_accessor :notifications_queue

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
