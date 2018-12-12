# frozen_string_literal: true

require 'logger'

class CheapLogger
  # Comment
  class LogActually
    include Formatter
    extend Forwardable
    include Constants

    def_delegators :logger, *Logger.instance_methods(false)

    attr_accessor :logger

    def initialize(stream = STDOUT)
      @logger = Logger.new(stream)
      logger.formatter = default_formatter
      logger.sev_threshold = DEFAULT_LEVEL
    end

    def d
      logger.sev_threshold = Logger::DEBUG
    end

    def i
      logger.sev_threshold = Logger::INFO
    end
  end
end
