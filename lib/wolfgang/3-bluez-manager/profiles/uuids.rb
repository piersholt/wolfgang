# frozen_string_literal: true

module Wolfgang
  # Profiles
  module Profiles
    BASE_UUID_SUFFIX = '1000-8000-00805f9b34fb'
    BASE_UUID = '00000000-0000-' + BASE_UUID_SUFFIX

    SERVICE_CLASS_IDENTIFIER_MAP = {
      0x110D => A2DP::PROFILE,
      0x110A => A2DP::SOURCE,
      0x110B => A2DP::SINK,

      0x110E => AVRCP::PROFILE,
      0x110C => AVRCP::TARGET,
      0x110F => AVRCP::CONTROLLER,

      0x111E => HFP::UNIT,
      0x111F => HFP::GATEWAY,

      0x1116 => NAP::NAP,

      0x112E => PBAP::PCE,
      0x112F => PBAP::PSE,
      0x1130 => PBAP::PBAP,

      0x1132 => MAP::MAS,
      0x1133 => MAP::MNS,
      0x1134 => MAP::MAP,

      0x1200 => DID::PNP
    }.freeze
  end
end
