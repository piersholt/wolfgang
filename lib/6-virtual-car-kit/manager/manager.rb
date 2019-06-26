# frozen_string_literal: true

class VirtualCarKit
  # Comment
  class Manager
    include Messaging::API
    attr_reader :manager

    def initialize(outgoing_notifications_queue)
      @manager_role = Core::ManagerRole.new(outgoing_notifications_queue)
      # @manager_role.notifications_queue = outgoing_notifications_queue
      @manager = @manager_role.manager
    end

    def punch_it_chewie
      announce(Messaging::Constants::DEVICE)
    end
  end
end
