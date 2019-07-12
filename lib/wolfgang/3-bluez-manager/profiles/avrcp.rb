# frozen_string_literal: true

module Wolfgang
  module Profiles
    # AVRCP
    module AVRCP
      PROFILE = {
        identifier: '0x110E',
        service_class_name: 'A/V_RemoteControl',
        specification: 'Audio/Video Remote Control Profile (AVRCP)',
        allowed_usage: 'Service Class/Profile'
      }.freeze

      TARGET = {
        identifier: '0x110C',
        service_class_name: 'A/V_RemoteControlTarget',
        specification: 'Audio/Video Remote Control Profile (AVRCP)',
        allowed_usage: 'Service Class'
      }.freeze

      CONTROLLER = {
        identifier: '0x110F',
        service_class_name: 'A/V_RemoteControlController',
        specification: 'Audio/Video Remote Control Profile (AVRCP)',
        allowed_usage: 'Service Class'
      }.freeze
    end
  end
end
