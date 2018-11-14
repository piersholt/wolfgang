# ----- Bluez CONTROLLER Object Interfaces ----- #

module BluezMediaTransport

  # Acquire
  # TryAcquire
  # Release

  # Properties
  #
  # object Device [readonly]
  #
	# 	Device object which the transport is connected to.
  #
	# string UUID [readonly]
  #
	# 	UUID of the profile which the transport is for.
  #
	# byte Codec [readonly]
  #
	# 	Assigned number of codec that the transport support.
	# 	The values should match the profile specification which
	# 	is indicated by the UUID.
  #
	# array{byte} Configuration [readonly]
  #
	# 	Configuration blob, it is used as it is so the size and
	# 	byte order must match.
  #
	# string State [readonly]
  #
	# 	Indicates the state of the transport. Possible
	# 	values are:
	# 		"idle": not streaming
	# 		"pending": streaming but not acquired
	# 		"active": streaming and acquired
  #
	# uint16 Delay [readwrite]
  #
	# 	Optional. Transport delay in 1/10 of millisecond, this
	# 	property is only writeable when the transport was
	# 	acquired by the sender.
  #
	# uint16 Volume [readwrite]
  #
	# 	Optional. Indicates volume level of the transport,
	# 	this property is only writeable when the transport was
	# 	acquired by the sender.
  #
	# 	Possible Values: 0-127


end
