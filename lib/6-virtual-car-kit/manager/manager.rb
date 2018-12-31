# frozen_string_literal: true

class VirtualCarKit
  # Comment
  class Manager
    attr_reader :manager

    def initialize(outgoing_notifications_queue)
      @manager_role = Core::ManagerRole.new(outgoing_notifications_queue)
      # @manager_role.notifications_queue = outgoing_notifications_queue
      @manager = @manager_role.manager
    end

    # alias m manager
  end
end
