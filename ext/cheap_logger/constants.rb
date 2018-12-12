# frozen_string_literal: true

class CheapLogger
  module Constants
    RESET = '0'
    LIGHT_GRAY = '37'
    GREEN = '32'
    YELLOW = '33'
    RED = '31'
    MAGENTA = '35'

    DEFAULT_LEVEL = Logger::INFO

    SEVERITY_TO_COLOUR_MAP = {
      'DEBUG' => :gray,
      'INFO' => :green,
      'WARN' => :yellow,
      'ERROR' => :red,
      'FATAL' => :red,
      'UNKNOWN' => :magenta,
      'ANY' => :magenta
    }.freeze
  end
end
