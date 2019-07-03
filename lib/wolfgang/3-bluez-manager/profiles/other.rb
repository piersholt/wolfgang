# frozen_string_literal: true

module Wolfgang
  module Profiles
    module NAP
      NAP = {
        identifier: '0x1116',
        service_class_name: 'NAP',
        specification: 'Personal Area Networking Profile (PAN)',
        allowed_usage: 'Service Class/Profile'
      }.freeze
    end

    # Phonebook Access Profile (PBAP)
    module PBAP
      PCE = {
        identifier: '0x112E',
        service_class_name: 'Phonebook Access - PCE',
        specification: 'Phonebook Access Profile (PBAP)',
        allowed_usage: 'Service Class'
      }.freeze
      PSE = {
        identifier: '0x112F',
        service_class_name: 'Phonebook Access - PSE',
        specification: 'Phonebook Access Profile (PBAP)',
        allowed_usage: 'Service Class'
      }.freeze
      PBAP = {
        identifier: '0x1130',
        service_class_name: 'Phonebook Access',
        specification: 'Phonebook Access Profile (PBAP)',
        allowed_usage: 'Profile'
      }.freeze
    end

    # Message Access Profile (MAP)
    module MAP
      MAS = {
        identifier: '0x1132',
        service_class_name: 'Message Access Server',
        specification: 'Message Access Profile (MAP)',
        allowed_usage: 'Service Class'
      }.freeze
      MNS = {
        identifier: '0x1133',
        service_class_name: 'Message Notification Server',
        specification: 'Message Access Profile (MAP)',
        allowed_usage: 'Service Class'
      }.freeze
      MAP = {
        identifier: '0x1134',
        service_class_name: 'Message Access Profile',
        specification: 'Message Access Profile (MAP)',
        allowed_usage: 'Profile'
      }.freeze
    end

    # Hands-Free Profile (HFP)
    module HFP
      UNIT = {
        identifier: '0x111E',
        service_class_name: 'HandsfreeAudioGateway',
        specification: 'Hands-free Profile (HFP)',
        allowed_usage: 'Service Class/Profile'
      }.freeze
      GATEWAY = {
        identifier: '0x111F',
        service_class_name: 'HandsfreeAudioGateway',
        specification: 'Hands-free Profile (HFP)',
        allowed_usage: 'Service Class'
      }.freeze
    end

    # Device Identification (DID)
    module DID
      PNP = {
        identifier: '0x1200',
        service_class_name: 'PnPInformation',
        specification: 'Device Identification (DID)',
        allowed_usage: 'Service Class/Profile'
      }.freeze
    end
  end
end
