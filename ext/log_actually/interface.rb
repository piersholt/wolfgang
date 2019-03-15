# frozen_string_literal: true

# Comment
class LogActually
  def self.is_all_around(id, stream = STDERR)
    log = Log.new(id, stream)
    Forrest.instance.add(id, log)
    send(id)
  end

  def self.welcome
    log = Log.new(:welcome, STDERR)
    Forrest.instance.add(:welcome, log)
    welcome_log = Forrest.instance.loggers[:welcome]
    welcome_log.info('LogActually') { 'Beause log actually..., is all around. ❤️' }
    Forrest.instance.remove(:welcome)
    true
  end
end

class LogActually
  # Mixin for common error logging output
  module ErrorOutput
    def with_backtrace(logger, error, progname = self.class.name)
      logger.error(progname) { error }
      error.backtrace.each { |line| logger.error(line) }
    end

    def simple(logger, error, progname = self.class.name)
      logger.error(progname) { error }
    end

    def extra(logger, message, progname = self.class.name)
      if progname
        logger.warn(progname) { message }
      else
        logger.warn { message }
      end
    end

    def i(message, progname = self.class.name, logger = :default)
      LogActually.public_send(logger).info(progname) { message }
    end

    def d(message, progname = self.class.name, logger = :default)
      LogActually.public_send(logger).debug(progname) { message }
    end
  end
end
