# frozen_string_literal: true

module AVRCP
  class Player
    # Comment
    module State
      def attributes
        @attributes ||= {}
      end

      def squish(old, new)
        old.merge(new)
      end

      def attributes!(changes)
        attributes.merge!(changes) do |_, old, new|
          old.instance_of?(Hash) ? squish(old, new) : new
        end
      end
    end
  end
end