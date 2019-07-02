# frozen_string_literal: true

# lib_path = File.expand_path(File.dirname(__FILE__)+ '/../lib')
# $LOAD_PATH.unshift(lib_path)

class FileUtils
  def root(parent = '.')
    File.expand_path(parent, __dir__)
  end
end
