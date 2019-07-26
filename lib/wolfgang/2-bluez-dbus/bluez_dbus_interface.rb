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

    alias start run

    def quit!
      BluezDBus.quit
    end

    alias stop quit!

    def signals(opts)
      BluezDBus.signals(opts)
    end
  end
end
