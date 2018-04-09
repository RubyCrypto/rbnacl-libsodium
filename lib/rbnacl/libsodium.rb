require "rbnacl/libsodium/version"

module RbNaCl
  # Installer for the libsodium native library
  module Libsodium
    class << self
      def sodiumlib_dir
        dist_dirs = ["tmp/#{RUBY_PLATFORM}/stage/vendor/libsodium/dist", "vendor/libsodium/dist"]
        lib_dirs = %w[lib lib64]
        sodiumlib_dirs = dist_dirs.product(lib_dirs).map do |dist_dir, lib_dir|
          File.expand_path("../../../#{dist_dir}/#{lib_dir}/", __FILE__)
        end
        sodiumlib_dirs.select { |dir| Dir.exist?(dir) }.first
      end

      def sodiumlib_glob
        case RUBY_DESCRIPTION
        when /darwin/ then "libsodium*.dylib"
        when /Windows|(win|mingw)32/ then "../bin/libsodium*.dll"
        when /openbsd/ then "libsodium*.so.*"
        else "libsodium*.so"
        end
      end
    end

    ::RBNACL_LIBSODIUM_GEM_LIB_PATH = Dir.glob(File.join(sodiumlib_dir, sodiumlib_glob)).first
  end
end

require "rbnacl"
