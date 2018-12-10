# frozen_string_literal: true

# delegation.rb

dbus_root = '2-bluez-dbus'
delegation_root = "#{dbus_root}/base/delegation"

require "#{delegation_root}/delegate_validation"
require "#{delegation_root}/signal_delegate_validation"
require "#{delegation_root}/signal_delegate"
require "#{delegation_root}/signal_delegator"
