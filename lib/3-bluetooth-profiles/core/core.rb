# frozen_string_literal: true

core_root = '3-bluetooth-profiles/core'
manager = core_root + '/manager'
device = core_root + '/device'

# MANAGER
require "#{manager}/signal_handling"
require "#{manager}/notifications"
require "#{manager}/manager"

# DEVICE
require "#{device}/attributes"
require "#{device}/state"
require "#{device}/device"

require "#{core_root}/manager_role.rb"
