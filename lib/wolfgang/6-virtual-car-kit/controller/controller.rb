# frozen_string_literal: true

module Wolfgang
  class VirtualCarKit
    # Controller
    class Controller
      attr_reader :target

      def initialize(outgoing_notifications_queue)
        @target_role = AVRCP::TargetRole.new(outgoing_notifications_queue)
        @target = @target_role.target
      end
    end
  end
end
