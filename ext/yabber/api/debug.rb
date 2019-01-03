# frozen_string_literal: true

module Messaging
  module API
    # Comment
    module Debug
      include Constants

      def hello
        thy_will_be_done!(DEBUG, HELLO)
      end
    end
  end
end
