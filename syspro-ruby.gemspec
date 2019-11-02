# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'syspro/version'

Gem::Specification.new do |spec|
  spec.name          = 'syspro-ruby'
  spec.version       = Syspro::VERSION
  spec.authors       = ['Sam Clopton', 'Nathan Ockerman']
  spec.email         = ['sam@wild.land', 'nathan@wild.land']

  spec.summary       = 'SYSPRO 7 Api Ruby adapter'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'http://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end
  spec.required_ruby_version = '>= 1.9.0'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency('faraday', '~> 0.10')
  spec.add_dependency('nokogiri', '>= 1.8.2', '< 1.11.0')

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'pry', '~> 0.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.54.0'
  spec.add_development_dependency 'webmock', '~> 3.3.0'
  spec.add_development_dependency 'minitest-vcr', '~> 1.4.0'
end
