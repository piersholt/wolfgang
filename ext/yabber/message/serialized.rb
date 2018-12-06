# frozen_string_literal: true

module Messaging
  # Comment
  class Serialized
    include Serialization

    def initialize(serialized_object, format = Defaults::SERIALIZED_FORMAT)
      @deserialized_object = parse_object(serialized_object, format)
      valid?
    end

    def type
      @deserialized_object[:type]
    end

    def version
      @deserialized_object[:version]
    end

    def topic
      @deserialized_object[:topic]
    end

    def parse
      klass.new(topic: topic)
    end

    def klass
      TYPE_CLASS_MAP[type]
    end

    def valid?
      version_match?
      validate_type(type)
      validate_topic(topic)
      validate_version(version)
    end

    def version_match?
      versions_match = version == Defaults::VERSION
      raise EncodingError, 'Version mismatch!' unless versions_match
    end
  end
end
