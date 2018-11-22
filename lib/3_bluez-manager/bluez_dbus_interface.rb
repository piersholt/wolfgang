# frozen_string_literal: true

module BluezDBusInterface
  def service
    BluezDBus.service
  end

  def run
    BluezDBus.run
  end

  def quit!
    BluezDBus.quit
  end

  def signals
    BluezDBus.signals
  end
end
