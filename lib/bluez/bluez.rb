module Bluez
  module Interface
    module Properties
      NAME = 'org.freedesktop.DBus.Properties'
      METHODS = %i(get get_all set)
    end

    module Introspectable
      NAME = 'org.freedesktop.DBus.Introspectable'
      METHODS = %i(introspect)
    end

    module ObjectManager
      NAME = 'org.freedesktop.DBus.ObjectManager'
      METHODS = %i(get_managed_objects)

      def get_managed_objects
        interfaced_object = @base_object[NAME]
        interfaced_object.GetManagedObjects
      end
    end

    module BaseInterface
      DOMAIN = 'org.bluez.'
    end

    module Adapter1
      include BaseInterface

      NAME = DOMAIN + 'Adapter1'
      attr_reader :UUIDs, :Discoverable
    end

    module GattManger1
      include BaseInterface

      NAME = DOMAIN + 'GattManger1'
    end

    module Media1
      include BaseInterface

      NAME = DOMAIN + 'Media1'
    end

    module NetworkServer1
      include BaseInterface

      NAME = DOMAIN + 'NetworkServer1'
    end

    module Device1
      include BaseInterface

      NAME = DOMAIN + 'Device1'
    end

    module MediaControl1
      include BaseInterface

      NAME = DOMAIN + 'MediaControl1'
    end

    module Network1
      include BaseInterface

      NAME = DOMAIN + 'Network1'
    end
  end

  class BaseObject
    def initialize(base_object)
      @base_object = base_object
    end
  end

  class Root < BaseObject
    include Interface::Introspectable
    include Interface::ObjectManager

    # def initialize(dbus_root_object)
    #   @dbus_root_object = dbus_root_object
    # end

    def objects
    end
  end

  class Controller < BaseObject
    include Interface::Introspectable
    include Interface::Properties

    include Interface::Adapter1
    include Interface::GattManger1
    include Interface::Media1
    include Interface::NetworkServer1

    def devices
    end

    def device(id)
    end
  end

  class Device < BaseObject
    include Interface::Introspectable
    include Interface::Properties

    include Interface::Device1
    include Interface::MediaControl1
    include Interface::Network1
  end

  class Service

    def initialize(dbus_service)
      @dbus_service = dbus_service
    end

    def controllers
    end

    def controller(id)
    end

    private

    def inspect_service
      root_object = @dbus_service.object('/')
      root = Root.new(result)
    end




  end
end
