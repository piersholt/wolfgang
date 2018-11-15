# Interface Names

# frozen_string_literal: true

# /org/bluez
BLUEZ_AGENT_MANAGER   = 'org.bluez.AgentManager1'
BLUEZ_HEALTH_MANAGER  = 'org.bluez.HealthManager1'
BLUEZ_PROFILE_MANAGER = 'org.bluez.ProfileManager1'

# /org/bluez/hci{x}
BLUEZ_ADAPTER         = 'org.bluez.Adapter1'
BLUEZ_GATT_MANAGER    = 'org.bluez.GattManager1'
BLUEZ_MEDIA           = 'org.bluez.Media1'
BLUEZ_NETWORK_SERVER  = 'org.bluez.NetworkServer1'

# /org/bluez/dev_{xx:xx:xx:xx:xx:xx}
BLUEZ_DEVICE        = 'org.bluez.Device1'
BLUEZ_MEDIA_CONTROL = 'org.bluez.MediaControl1'
BLUEZ_NETWORK       = 'org.bluez.Network1'

# /org/bluez/{device}/fd{x}
BLUEZ_MEDIA_TRANSPORT = 'org.bluez.MediaTransport1'

# /org/bluez/{device}/player{x}
BLUEZ_MEDIA_PLAYER = 'org.bluez.MediaPlayer1'
