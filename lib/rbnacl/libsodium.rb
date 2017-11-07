require "rbnacl/libsodium/version"

module RbNaCl
  module Libsodium
    sodiumlib_dir = File.expand_path("../../../vendor/libsodium/dist/lib/", __FILE__)

    sodiumlib_glob = case RUBY_DESCRIPTION
    when /darwin/ then "libsodium*.dylib"
    when /Windows|(win|mingw)32/ then "libsodium*.dll"
    when /openbsd/ then "libsodium*.so.*"
    else "libsodium*.so"
    end

    ::RBNACL_LIBSODIUM_GEM_LIB_PATH = Dir.glob(File.join(sodiumlib_dir, sodiumlib_glob)).first
  end
end

require "rbnacl"
