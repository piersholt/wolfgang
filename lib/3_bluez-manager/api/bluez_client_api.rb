# frozen_string_literal: true

module BluezClientAPI; end

require '3_bluez-manager/api/debug'
require '3_bluez-manager/api/service'
require '3_bluez-manager/api/controller'
require '3_bluez-manager/api/device'

module BluezClientAPI
  extend Controller
  extend Device
end
