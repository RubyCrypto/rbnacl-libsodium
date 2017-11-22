require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'rake/extensiontask'

RSpec::Core::RakeTask.new

task default: :spec

MAKE = ENV['MAKE'] || ENV['make'] || "make"
RUBY_CC_VERSION = ENV['RUBY_CC_VERSION'] || '2.3.0'

desc "Build Windows binary packages"
task 'gem:windows' do
  require 'rake_compiler_dock'
  if File.exist? "vendor/libsodium/Makefile"
    RakeCompilerDock.sh "cd vendor/libsodium && #{MAKE} clean"
  end
  sh "bundle package"   # Avoid repeated downloads of gems by using gem files from the host.
  RakeCompilerDock.sh "bundle --local && RUBY_CC_VERSION=#{RUBY_CC_VERSION} rake cross native gem"
end

spec = Gem::Specification.load("rbnacl-libsodium.gemspec")

PLATFORMS = ['x86-mingw32', 'x64-mingw32']
Rake::ExtensionTask.new("fake_ext", spec) do |ext|
  ext.ext_dir = 'ext/rbnacl'
  ext.cross_compile = true
  ext.cross_platform = PLATFORMS
  ext.cross_config_options << {
    'x86-mingw32' => '--with-host=i686-w64-mingw32',
    'x64-mingw32' => '--with-host=x86_64-w64-mingw32'
  }
  ext.cross_compiling do |gem_spec|
    gem_spec.files.reject! { |f| /lib\/fake_ext\.so\Z/ =~ f }
    stage_path = "#{ext.tmp_dir}/#{gem_spec.platform}/stage"
    gem_spec.files += Dir["#{stage_path}/vendor/libsodium/dist/**/*"].map do |stage|
      gem_path = stage.sub(stage_path + "/", "")
      # define empty task to skip copy from vendor/libsodium/dist/*
      task stage
      task gem_path
      gem_path
    end
    gem_spec.post_install_message = "You installed the binary version of this gem!"
  end
end

PLATFORMS.each do |platf|
  copy_task = "copy:fake_ext:#{platf}:#{RUBY_CC_VERSION}"
  if Rake::Task.task_defined?(copy_task)
    Rake::Task[copy_task].clear_actions
  end
end
