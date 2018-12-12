# frozen_string_literal: true

# Comment
class CheapLogger
  def self.get_to_the_logger!(id, stream = STDOUT)
    log = LogActually.new(stream)
    Forrest.instance.add(id, log)
    send(id)
  end
end
