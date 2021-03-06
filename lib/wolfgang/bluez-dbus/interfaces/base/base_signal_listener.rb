# frozen_string_literal: true

module Wolfgang
  # BaseSignalListener
  class BaseSignalListener
    include InterfaceConstants
    include ObjectHelpers
    include ObjectManagerListener
    include PropertiesListener
    attr_writer :proc

    PROC = 'BaseSignalListener'
    PROG = PROC
    DEFAULT_INDENT_DEPTH = 2

    # INDENT = '\t'

    private

    def logger?
      return logger if respond_to?(:logger)
      LOGGER
    end

    def prog?
      return prog if respond_to?(:prog)
      proc
    end

    def indent(depth)
      char_buffer = []
      indent_char = "\t"
      depth.times do |_|
        char_buffer << indent_char
      end
      char_buffer.join
    end

    # @param Hash properties
    def parse_properties(properties, depth = DEFAULT_INDENT_DEPTH)
      properties.each do |property, value|
        if value.instance_of?(Hash)
          logger?.debug(prog?) { "#{indent(depth)}#{property} =" }
          parse_properties(value, 3)
        else
          logger?.debug(prog?) { "#{indent(depth)}#{property} = #{value}" }
        end
      end
    rescue StandardError => e
      logger?.error(prog?) { e }
      e.backtrace.each { |line| logger?.error(prog?) { line } }
    end

    alias parse_changed parse_properties

    # @param Array properties
    def parse_removed(properties, depth = DEFAULT_INDENT_DEPTH)
      properties.each do |property|
        logger?.debug(prog) { "#{indent(depth)}Removed: #{property}" }
      end
    end

    def instance_info
      logger?.debug(prog?) { "Thread: #{Thread.current}: #{Thread.current[:name]}" }
      logger?.debug(prog?) { "Object: #{self}" }
    end

    def proc
      @proc || self.class.name[5..-9]
    end
  end
end
