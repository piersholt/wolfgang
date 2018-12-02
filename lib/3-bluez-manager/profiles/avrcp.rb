# frozen_string_literal: true

# Comment
module Profiles::AVRCP
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
