# frozen_string_literal: true

require 'rbczmq'
require 'singleton'

require 'yabber/constants'
require 'yabber/defaults'
require 'yabber/validation'
require 'yabber/object_validation'

require 'yabber/message/base_message'
require 'yabber/message/action'
require 'yabber/message/notification'

require 'yabber/klasses'
require 'yabber/serialization'
require 'yabber/message/serialized'

require 'yabber/queue/thread_safe'
require 'yabber/queue/announce'
require 'yabber/queue/messaging_queue'
require 'yabber/queue/publisher'
require 'yabber/queue/subscriber'
require 'yabber/queue/server'
require 'yabber/queue/client'

require 'yabber/api/debug'
require 'yabber/api/manager'
require 'yabber/api/controller'
require 'yabber/api/api'

require 'yabber/delegation/chain_errors'
require 'yabber/delegation/delegate_validation'
require 'yabber/delegation/notification_delegate_validation'
require 'yabber/delegation/notification_delegate'
require 'yabber/delegation/notification_delegator'
require 'yabber/delegation/notification_handler'
