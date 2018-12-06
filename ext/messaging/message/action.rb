
# frozen_string_literal: true

module Messaging
  # Comment
  class Action < BaseMessage
    attr_accessor :name, :properties

    def initialize(topic:, name: nil, properties: {})
      super(type: ACTION, topic: topic)
      @name = name if name
      @properties = properties if properties
    end

    def hashified
      { action: { name: name } }
    end

    def to_h
      base = super
      me = hashified
      base.merge(me)
    end
  end
end