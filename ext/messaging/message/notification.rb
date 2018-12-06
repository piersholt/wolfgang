# frozen_string_literal: true

module Messaging
  # Comment
  class Notification < BaseMessage
    attr_accessor :name, :properties

    def initialize(topic:, name: nil, properties: {})
      super(type: NOTIFICATION, topic: topic)
      @name = name if name
      @properties = properties if properties
    end

    def hashified
      { notification: { name: name, properties: properties } }
    end

    def to_h
      base = super
      me = hashified
      base.merge(me)
    end

    def to_s
      "#{self.class}: #{topic} / #{name} / #{properties}"
    end
  end
end
