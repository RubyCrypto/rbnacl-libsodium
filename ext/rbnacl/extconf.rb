# frozen_string_literal: true

require "mkmf"

def sys(cmd)
  puts " -- #{cmd}"
  ret = system(cmd)
  raise "ERROR: '#{cmd}' failed" unless ret
  ret
end

mkfl = <<MAKEFILE
install:
\t@echo "Nothing to do"

clean:
\t@echo "Nothing to do"
MAKEFILE

HOST = arg_config("--host")
OPTIONS = [].freeze
OPTIONS << "--host=#{HOST}" if HOST

CWD = __dir__
LIBSODIUM_DIR = File.expand_path(File.join(CWD, "..", "..", "vendor", "libsodium"))
MAKE = ENV["MAKE"] || ENV["make"] || "make"
DIST = if HOST
         # install to the stage directory for rake-compiler
         File.expand_path(File.join(CWD, "..", "..", "tmp", RUBY_PLATFORM, "stage", "vendor", "libsodium", "dist"))
       else
         "#{LIBSODIUM_DIR}/dist".freeze
       end

Dir.chdir(LIBSODIUM_DIR) do
  # sh is required to run configure on Windows
  sys("sh -c \"./configure --prefix=#{DIST} #{OPTIONS.join(' ')}\"")
  sys("#{MAKE} clean") if HOST
  sys(MAKE)
  sys("#{MAKE} install")
end

File.open("Makefile", "w") do |f|
  f.write(mkfl)
end
