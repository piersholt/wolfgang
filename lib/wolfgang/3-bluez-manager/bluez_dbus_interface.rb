# frozen_string_literal: true

module Wolfgang
  # BluezDBusInterface
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

    def signals(opts)
      BluezDBus.signals(opts)
    end
  end
end
