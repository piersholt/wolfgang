# frozen_string_literal: true

module Wolfgang
  module Profiles
    # A2DP
    module A2DP
      PROFILE = {
        identifier: '0x110D',
        service_class_name: 'AdvancedAudioDistribution',
        specification: 'Advanced Audio Distribution Profile (A2DP)',
        allowed_usage: 'Profile Class'
      }.freeze

      SOURCE = {
        identifier: '0x110A',
        service_class_name: 'AudioSource',
        specification: 'Advanced Audio Distribution Profile (A2DP)',
        allowed_usage: 'Service Class'
      }.freeze

      SINK = {
        identifier: '0x110B',
        service_class_name: 'AudioSink',
        specification: 'Advanced Audio Distribution Profile (A2DP)',
        allowed_usage: 'Service Class'
      }.freeze
    end
  end
end
