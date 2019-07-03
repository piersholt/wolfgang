# frozen_string_literal: true

module Wolfgang
  module Profiles
    # AVRCP
    module AVRCP
      PROFILE = {
        service_class_name: 'A/V_RemoteControl',
        specification: 'Audio/Video Remote Control Profile (AVRCP)',
        allowed_usage: 'Service Class/Profile'
      }.freeze

      TARGET = {
        service_class_name: 'A/V_RemoteControlTarget',
        specification: 'Audio/Video Remote Control Profile (AVRCP)',
        allowed_usage: 'Service Class'
      }.freeze

      CONTROLLER = {
        service_class_name: 'A/V_RemoteControlController',
        specification: 'Audio/Video Remote Control Profile (AVRCP)',
        allowed_usage: 'Service Class'
      }.freeze
    end
  end
end
