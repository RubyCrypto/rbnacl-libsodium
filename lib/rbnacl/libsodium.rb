require "rbnacl/libsodium/version"

module RbNaCl
  module Libsodium
    sodiumlib_dir = File.expand_path("../../../vendor/libsodium/dist/lib/", __FILE__)

    sodiumlib_filename = case RUBY_DESCRIPTION
    when /darwin/ then "libsodium.dylib"
    when /Windows|(win|mingw)32/ then "libsodium.dll"
    else "libsodium.so"
    end

    ::RBNACL_LIBSODIUM_GEM_LIB_PATH = File.join(sodiumlib_dir, sodiumlib_filename)
  end
end

require "rbnacl"
