# frozen_string_literal: true

puts 'wolfgang/bluez-manager/api'

module BluezClientAPI; end

require_relative 'api/debug'
require_relative 'api/service'
require_relative 'api/controller'
require_relative 'api/device'

module BluezClientAPI
  extend Controller
  extend Device
end