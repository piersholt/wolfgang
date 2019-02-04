# frozen_string_literal: true

module Messaging
  # Comment
  class Request < BaseMessage
    attr_accessor :name, :properties

    def initialize(topic:, name: nil, properties: {})
      super(type: REQUEST, topic: topic)
      @name = name if name
      @properties = properties if properties
    end

    def hashified
      { request: { name: name, properties: properties } }
    end

    def to_h
      base = super
      me = hashified
      base.merge(me)
    end

    def to_s
      "#{self.class}: Topic: #{topic}, Name: #{name}, Properties: #{properties}"
    end
  end
end

module Messaging
  # Comment
  class Reply < BaseMessage
    attr_accessor :name, :properties

    def initialize(topic:, name: nil, properties: {})
      super(type: REPLY, topic: topic)
      @name = name if name
      @properties = properties if properties
    end

    def hashified
      { reply: { name: name, properties: properties } }
    end

    def to_h
      base = super
      me = hashified
      base.merge(me)
    end

    def to_s
      "#{self.class}: Topic: #{topic}, Name: #{name}, Properties: #{properties}"
    end
  end
end
