# frozen_string_literal: true

# Comment
class LogActually
  def self.is_all_around(id, stream = STDOUT)
    log = Log.new(stream)
    Forrest.instance.add(id, log)
    send(id)
  end

  def self.welcome
    log = Log.new(STDOUT)
    Forrest.instance.add(:welcome, log)
    welcome_log = Forrest.instance.loggers[:welcome]
    welcome_log.info('LogActually') { 'Beause log actually..., is all around.' }
    Forrest.instance.remove(:welcome)
    true
  end
end
