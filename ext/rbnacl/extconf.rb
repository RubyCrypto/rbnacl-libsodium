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
  sys("./configure --prefix=#{LIBSODIUM_DIR}/dist")
  sys(MAKE)
  sys("#{MAKE} install")
end

File.open("Makefile", "w") do |f|
  f.write(mkfl)
end
