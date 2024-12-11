require File.expand_path('lib/foreman_metal/version', __dir__)

Gem::Specification.new do |s|
  s.name        = 'foreman_metal'
  s.version     = ForemanPluginTemplate::VERSION
  s.metadata    = { 'is_foreman_plugin' => 'true' }
  s.license     = 'GPL-3.0'
  s.authors     = ['Matthew F Heller']
  s.email       = ['matthew.f.heller@accre.vanderbilt.edu']
  s.homepage    = 'https://github.com/hellermf/foreman_metal'
  s.summary     = 'Foreman compute resource plugin for bare metal...particularly for IPMI KVM/SOL via VNC.'
  # also update locale/gemspec.rb
  s.description = 'Foreman compute resource provider interface for bare metal...particularly for IPMI KVM/SOL via VNC console.'

  s.files = Dir['{app,config,db,lib,locale,webpack}/**/*'] + ['LICENSE', 'Rakefile', 'README.md', 'package.json']
  s.test_files = Dir['test/**/*'] + Dir['webpack/**/__tests__/*.js']

  s.required_ruby_version = '>= 2.7', '< 4'

  s.add_development_dependency 'rdoc', '~> 6.2'
end
