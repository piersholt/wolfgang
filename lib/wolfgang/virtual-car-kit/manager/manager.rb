# frozen_string_literal: true

module Wolfgang
  class VirtualCarKit
    # Manager
    class Manager
      include Yabber::API
      attr_reader :manager

      def initialize(outgoing_notifications_queue)
        @manager_role = Core::ManagerRole.new(outgoing_notifications_queue)
        @manager = @manager_role.manager
      end

      def punch_it_chewie
        announce(Yabber::Constants::DEVICE)
      end

      def devices
        manager.devices
      end

      def device(nickname)
        manager.device(nickname)
      end
    end
  end
end
