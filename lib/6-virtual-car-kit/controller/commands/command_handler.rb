# frozen_string_literal: true

# Comment
# TODO: MediaCommandHandler
class CommandHandler
  include Singleton
  include NotificationDelegate

  attr_accessor :target

  def thy_will_be_done!(command)
    # LOGGER.info(self.class) { command }
    command = Messaging::Serialized.new(command).parse
    LOGGER.info(self.class) { "Deserialized: #{command}" }
    LOGGER.info(self.class) { "name: #{command.name} (#{command.name.class})" }
    case command.name
    when :seek_next_execute
      seek_next(command)
    when :seek_previous_execute
      seek_previous(command)
    when :scan_next_commence
      not_handled(command)
    when :scan_next_conclude
      not_handled(command)
    when :scan_previous_commence
      not_handled(command)
    when :scan_previous_conclude
      not_handled(command)
    end
  rescue StandardError => e
    LOGGER.error(PROC) { e }
    e.backtrace.each { |l| LOGGER.error(l) }
  end

  def seek_next(command)
    puts '!!!!!OIU@(E*Y FIUDHFULDKSHFLSKHDGFJ'
    LOGGER.unknown(self.class) { "Seek next! #{command.name}" }
    target.next
  end

  def seek_previous(command)
    LOGGER.unknown(self.class) { "Seek previous! #{command.name}" }
    target.previous
  end

  def not_handled(command)
    LOGGER.unknown(self.class) { "Ignored: #{command.name}" }
  end
end
