require "rbnacl/libsodium/version"

module RbNaCl
  module Libsodium
    sodiumlib_dir = File.expand_path(File.join(File.dirname(__FILE__), "../../vendor/libsodium/dist/lib/"))
    sodiumlib_filename = RUBY_DESCRIPTION =~ /darwin/ ? "libsodium.dylib" : "libsodium.so"
    ::RBNACL_LIBSODIUM_GEM_LIB_PATH = File.join(sodiumlib_dir, sodiumlib_filename)
  end
end

require "rbnacl"
