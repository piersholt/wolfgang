# frozen_string_literal: true

# Interface Signal Names
module SignalConstants
  OBJECT_MANAGER_SIGNALS = {
    interfaces_added: 'InterfacesAdded',
    interfaces_removed: 'InterfacesRemoved'
  }.freeze

  PROPERTIES_SIGNALS = {
    properties_changed: 'PropertiesChanged'
  }.freeze
end
