# frozen_string_literal: true

module Wolfgang
  module Profiles
    # A2DP
    module A2DP
      PROFILE = {
        service_class_name: 'AdvancedAudioDistribution',
        specification: 'Advanced Audio Distribution Profile (A2DP)',
        allowed_usage: 'Profile Class'
      }.freeze

      SINK = {
        service_class_name: 'AudioSink',
        specification: 'Advanced Audio Distribution Profile (A2DP)',
        allowed_usage: 'Service Class'
      }.freeze

      SOURCE = {
        service_class_name: 'AudioSource',
        specification: 'Advanced Audio Distribution Profile (A2DP)',
        allowed_usage: 'Service Class'
      }.freeze
    end
  end
end
