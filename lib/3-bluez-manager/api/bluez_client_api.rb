# frozen_string_literal: true

module BluezClientAPI; end

require '3-bluez-manager/api/debug'
require '3-bluez-manager/api/service'
require '3-bluez-manager/api/controller'
require '3-bluez-manager/api/device'

module BluezClientAPI
  extend Controller
  extend Device
end
