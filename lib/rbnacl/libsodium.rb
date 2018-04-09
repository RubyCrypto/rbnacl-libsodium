require "rbnacl/libsodium/version"

module RbNaCl
  # Installer for the libsodium native library
  module Libsodium
    class << self
      def sodiumlib_dir
        dist_dirs = ["tmp/#{RUBY_PLATFORM}/stage/vendor/libsodium/dist", "vendor/libsodium/dist"]
        lib_dirs = %w[lib lib64]
        sodiumlib_dirs = dist_dirs.product(lib_dirs).map do |dist_dir, lib_dir|
          File.expand_path("../../#{dist_dir}/#{lib_dir}/", __dir__)
        end

        sodiumlib_dirs.select { |dir| Dir.exist?(dir) }.first.tap do |dir|
          raise ExtensionNotFoundError, "libsodium not found!" unless dir
        end
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

  # Couldn't find our own libsodium build!
  ExtensionNotFoundError = Class.new(StandardError)

  # A severe error in which two versions of libsodium may wind up linked into
  # the VM. Since this is a potential memory safety violation, we use Exception
  # instead of StandardError as a signal the VM is tainted and should probably
  # exit.
  #
  # See https://github.com/crypto-rb/rbnacl-libsodium/issues/24
  AlreadyLoadedError = Class.new(Exception)
end

unless require "rbnacl"
  # RbNaCl has already been loaded!
  raise RbNaCl::AlreadyLoadedError, "rbnacl already loaded against system's libsodium! Ruby VM may now be in a bad state"
end
