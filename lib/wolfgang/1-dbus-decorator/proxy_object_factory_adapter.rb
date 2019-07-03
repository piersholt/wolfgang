# frozen_string_literal: false

module Wolfgang
  # Wolfgang::ProxyObjectFactoryAdapter
  class ProxyObjectFactoryAdapter < DBus::ProxyObjectFactory
    def self.introspect_into(po, xml, interface: InterfaceAdapter)
      intfs, po.subnodes = DBus::IntrospectXMLParser.new(xml).parse
      intfs.each do |i|
        poi = interface.new(po, i.name)
        i.methods.each_value { |m| poi.define(m) }
        i.signals.each_value { |s| poi.define(s) }
        po[i.name] = poi
      end
      po.introspected = true
    end
  end
end
