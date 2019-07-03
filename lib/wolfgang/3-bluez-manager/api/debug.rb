# frozen_string_literal: true

module Wolfgang
  module BluezClientAPI
    # Debug
    module Debug
      def i
        LOGGER.sev_threshold = Logger::INFO
      end

      def d
        LOGGER.sev_threshold = Logger::DEBUG
      end
    end
  end
end
