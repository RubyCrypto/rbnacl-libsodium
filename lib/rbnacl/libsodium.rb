require "rbnacl/libsodium/version"

module RbNaCl
  module Libsodium
    sodiumlib32_dir = File.expand_path("../../../vendor/libsodium/dist/lib/", __FILE__)
    sodiumlib64_dir = File.expand_path("../../../vendor/libsodium/dist/lib64/", __FILE__)
    libsodium_dirs  = [sodiumlib32_dir, sodiumlib64_dir]
    sodiumlib_dir   = libsodium_dirs.select { |dir| Dir.exist?(dir) }.first

    sodiumlib_glob = case RUBY_DESCRIPTION
    when /darwin/ then "libsodium*.dylib"
    when /Windows|(win|mingw)32/ then "libsodium*.dll"
    else "libsodium*.so"
    end

    ::RBNACL_LIBSODIUM_GEM_LIB_PATH = Dir.glob(File.join(sodiumlib_dir, sodiumlib_glob)).first
  end
end

require "rbnacl"
