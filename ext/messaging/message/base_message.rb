# frozen_string_literal: true

require 'json'

module Messaging
  # Comment
  class BaseMessage
    include Constants
    include Validation
    include Defaults

    attr_reader :version, :topic, :type

    def initialize(version: VERSION, topic:, type:)
      validate_arguments(version: version, topic: topic, type: type)
      @version = version
      @topic = topic
      @type = type
    end

    def to_h
      { version: version,
        topic: topic,
        type: type }
    end

    def to_json
      to_h.to_json
    end

    def to_yaml
      to_h.to_yaml
    end

    private

    def validate_arguments(version:, topic:, type:)
      validate_topic(topic)
      validate_type(type)
      validate_version(version)
      true
    end
  end
end
