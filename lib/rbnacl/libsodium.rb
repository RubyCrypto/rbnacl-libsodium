require 'rbnacl/libsodium/version'

module RbNaCl
  module Libsodium
    class << self
      def sodiumlib_dir
        sodiumlib32_dir = File.expand_path('../../../vendor/libsodium/dist/lib/', __FILE__)
        sodiumlib64_dir = File.expand_path('../../../vendor/libsodium/dist/lib64/', __FILE__)
        [sodiumlib32_dir, sodiumlib64_dir].select { |dir| Dir.exist?(dir) }.first
      end

      def sodiumlib_glob
        case RUBY_DESCRIPTION
        when /darwin/ then 'libsodium*.dylib'
        when /Windows|(win|mingw)32/ then '../bin/libsodium*.dll'
        when /openbsd/ then 'libsodium*.so.*'
        else 'libsodium*.so'
        end
      end
    end

    ::RBNACL_LIBSODIUM_GEM_LIB_PATH = Dir.glob(File.join(sodiumlib_dir, sodiumlib_glob)).first
  end
end

require 'rbnacl'
