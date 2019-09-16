# frozen_string_literal: true

source 'https://rubygems.org'

ruby '~>2.4.0'

gem 'figaro'
gem 'pry-byebug'
gem 'ruby-dbus'
gem 'wilhelm-tools', git: 'https://github.com/piersholt/wilhelm-tools.git', branch: 'master'

group :production, optional: true do
  gem 'rpi_gpio'
end

group :development, optional: true do
  gem 'capistrano'
  gem 'capistrano-rbenv'
  gem 'rb-readline'
end
