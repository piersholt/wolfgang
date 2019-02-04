# frozen_string_literal: true

module Messaging
  module API
    # Comment
    module Controller
      include Constants

      def send_me_everyone
        everyone?
      end

      def everyone?
        evvveeerrrryyyyoooonnnneeee!
      end

      def evvveeerrrryyyyoooonnnneeee!
        thy_will_be_done!(CONTROLLER, EVERYONE)
      end

      def play!
        thy_will_be_done!(CONTROLLER, PLAY)
      end

      def pause!
        thy_will_be_done!(CONTROLLER, PAUSE)
      end

      def stop!
        thy_will_be_done!(CONTROLLER, STOP)
      end

      def next!
        thy_will_be_done!(CONTROLLER, SEEK_NEXT)
      end

      def previous!
        thy_will_be_done!(CONTROLLER, SEEK_PREVIOUS)
      end
    end
  end
end
