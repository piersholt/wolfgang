# frozen_string_literal: true

class BaseSignalListener
  include InterfaceConstants
  include ObjectManagerListener
  include PropertiesListener
  attr_writer :proc

  PROC = 'BaseSignalListener'
  DEFAULT_INDENT_DEPTH = 2

  # INDENT = '\t'

  private

  def indent(depth)
    char_buffer = []
    indent_char = "\t"
    depth.times do |_|
      char_buffer << indent_char
    end
    char_buffer.join
  end

  def parse_properties(properties, depth = DEFAULT_INDENT_DEPTH)
    properties.each do |property, value|
      if value.instance_of?(Hash)
        LOGGER.info(proc) { "#{indent(depth)}#{property} =" }
        parse_properties(value, 3)
      else
        LOGGER.info(proc) { "#{indent(depth)}#{property} = #{value}" }
      end
    end
  rescue StandardError => e
    LOGGER.error(proc) { e }
    e.backtrace.each { |line| LOGGER.error(proc) { line } }
  end

  def instance_info
    LOGGER.debug(proc) { "Thread: #{Thread.current}: #{Thread.current[:name]}" }
    LOGGER.debug(proc) { "Object: #{self}" }
  end

  def proc
    @proc || self.class.name[5..-9]
  end
end
