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

CWD = File.expand_path(File.dirname(__FILE__))
LIBSODIUM_DIR = File.expand_path(File.join(CWD, '..', '..', 'vendor', 'libsodium'))
MAKE = ENV['MAKE'] || ENV['make'] || "make"

Dir.chdir(LIBSODIUM_DIR) do
  # sh is required to run configure on Windows
  sys("sh -c \"./configure --prefix=#{LIBSODIUM_DIR}/dist\"")
  sys(MAKE)
  sys("#{MAKE} install")
  if !Dir.glob('dist/bin/libsodium*.dll').empty?
    # copy dll to make it loadable on Windows
    sys("cp dist/bin/libsodium*.dll dist/lib/libsodium.so")
  end
end

File.open("Makefile", "w") do |f|
  f.write(mkfl)
end
