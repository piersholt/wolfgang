# frozen_string_literal: true

puts "\tLoading wolfgang/bluetooth/profile/avrcp"

LogActually.is_all_around(:bt_ct)
LogActually.bt_ct.d

require_relative 'avrcp/controller'
