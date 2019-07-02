# frozen_string_literal: false

# All mehods that are expected to be overriden by SignalDelegate
module SignalDelegateValidation
  include DelegateValidation

  # The methods called when a handler is responsible
  def properties_changed(___ = nil)
    raise(NaughtyHandler, self.class.name)
  end

  def interface_called(___ = nil)
    raise(NaughtyHandler, self.class.name)
  end

  def interfaces_added(___ = nil)
    raise(NaughtyHandler, self.class.name)
  end

  def interfaces_removed(___ = nil)
    raise(NaughtyHandler, self.class.name)
  end
end
