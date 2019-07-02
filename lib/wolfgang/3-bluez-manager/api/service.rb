module BluezClientAPI::Service
  include Profiles

  def uuids(device_address = selected_device)
    device_object = service.device(device_address)
    device_properties = device_object.device.property_get_all
    device_properties['UUIDs']
  end

  def services
    uuids.find_all { |x| x.include?(BASE_UUID_SUFFIX) }
  end

  def service_identifiers
    result = uuids.find_all do |uuid|
      uuid.include?(BASE_UUID_SUFFIX)
    end

    result.map do |service_uuid|
      uuid_array = service_uuid.split('-')
      uuid_array.first[4..-1]
    end
  end

  def service_class(identifier_string)
    identifier = identifier_string.prepend('0x').hex
    return nil unless SERVICE_CLASS_IDENTIFIER_MAP.key?(identifier)
    SERVICE_CLASS_IDENTIFIER_MAP[identifier]
  end

  def service_classes
    service_identifiers.map do |ident|
      service_class(ident)
    end.compact
  end
end
