require 'mkmf'

def sys(cmd)
  puts " -- #{cmd}"
  unless ret = system(cmd)
    raise "ERROR: '#{cmd}' failed"
  end
  ret
end

mkfl = <<MAKEFILE
install:
\t@echo "Nothing to do"

clean:
\t@echo "Nothing to do"
MAKEFILE

HOST = arg_config("--host")
OPTIONS = []
if HOST
  OPTIONS << "--host=#{HOST}"
end

CWD = File.expand_path(File.dirname(__FILE__))
LIBSODIUM_DIR = File.expand_path(File.join(CWD, '..', '..', 'vendor', 'libsodium'))
MAKE = ENV['MAKE'] || ENV['make'] || "make"
if HOST
  # install to the stage directory for rake-compiler
  DIST = File.expand_path(File.join(CWD, '..', '..', 'tmp', RUBY_PLATFORM, 'stage', 'vendor', 'libsodium', 'dist'))
else
  DIST = "#{LIBSODIUM_DIR}/dist"
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
