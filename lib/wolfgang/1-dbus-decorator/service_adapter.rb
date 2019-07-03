# frozen_string_literal: false

module Wolfgang
  # Wolfgang::ServiceAdapter
  class ServiceAdapter < DBus::Service
    def [](path, adapter: ObjectAdapter)
      # puts "ServiceAdapter#[](#{path}, #{adapter})"
      object(path, api: DBus::ApiOptions::A1, adapter: adapter)
    end

    def object(path, api: DBus::ApiOptions::A0, adapter: ObjectAdapter)
      # puts "ServiceAdapter#object(#{path}, #{api}, #{adapter})"
      node = get_node(path, _create = true)

      if node.object.nil? || node.object.api != api
        node.object = adapter.new(
          @bus, @name, path,
          api: api
        )
      end
      node.object
    end
  end
end
