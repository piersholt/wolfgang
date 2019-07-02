# frozen_string_literal: true
module BluezClientAPI::Debug
  def i
    LOGGER.sev_threshold = Logger::INFO
  end

  def d
    LOGGER.sev_threshold = Logger::DEBUG
  end
end
