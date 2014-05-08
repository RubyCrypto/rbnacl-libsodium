require 'mkmf'

RbConfig::MAKEFILE_CONFIG['CC'] = ENV['CC'] if ENV['CC']

$CFLAGS << " #{ENV["CFLAGS"]}"

def sys(cmd)
  puts " -- #{cmd}"
  unless ret = xsystem(cmd)
    raise "ERROR: '#{cmd}' failed"
  end
  ret
end

if !(MAKE = find_executable('gmake') || find_executable('make'))
  abort "ERROR: GNU make is required to build libsodium."
end

CWD = File.expand_path(File.dirname(__FILE__))
LIBSODIUM_DIR = File.expand_path(File.join(CWD, '..', '..', 'vendor', 'libsodium'))

Dir.chdir(LIBSODIUM_DIR) do
  sys("./autogen.sh")
  sys("./configure --prefix=#{LIBSODIUM_DIR}/dist")
  sys(MAKE)
  sys("#{MAKE} install")
end

$DEFLIBPATH.unshift("#{LIBSODIUM_DIR}/dist")
dir_config('sodium', "#{LIBSODIUM_DIR}/dist/include", "#{LIBSODIUM_DIR}/dist/lib")

unless have_library 'sodium'
  abort "ERROR: Failed to build libsodium"
end

create_makefile("rbnacl-libsodium/rbnacl-libsodium")
