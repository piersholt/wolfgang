# frozen_string_literal: true

# delegation.rb

dbus_root = '2-bluez-dbus'
base_root = "#{dbus_root}/base"

require "#{base_root}/delegate_validation"
require "#{base_root}/signal_delegate_validation"
require "#{base_root}/signal_delegate"
require "#{base_root}/signal_delegator"
