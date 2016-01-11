# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'social_sharer/version'

Gem::Specification.new do |s|
  s.name        = 'social_sharer'
  s.version     = SocialSharer::VERSION
  s.version     = "#{s.version}-alpha-#{ENV['TRAVIS_BUILD_NUMBER']}" if ENV['TRAVIS']
  s.date        = '2015-10-16'
  s.summary     = 'A set of view helpers that allow users to create social sharing buttons easily'
  s.description = 'Adds a set of view methods that allow the users to create sharing buttons for multiple platforms. This gem allows you to customise the url for each platform adding \'tracking\' string if required.'
  s.authors     = ['Matthew Rayner']
  s.email       = 'matthew.rayner@thisisbd.com'
  s.files       = ['lib/social_sharer.rb']
  s.homepage    = 'http://github.com/thisisbd/social_sharer'
  s.license     = 'MIT'

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 1.9.3'

  s.add_development_dependency 'bundler', '~> 1.6'
  s.add_development_dependency 'rake', '~> 0.9.6'
  s.add_development_dependency 'yard', '~> 0.8.7.6'
  s.add_development_dependency 'pry', '~> 0.10.2'
  s.add_development_dependency 'pry-nav', '~> 0.2.4'
  s.add_development_dependency 'simplecov', '~> 0.10.0'
  s.add_development_dependency 'rubocop', '~> 0.34.2'
  s.add_development_dependency 'rspec', '~> 3.0'

  s.add_development_dependency 'coveralls'

  s.add_dependency 'rails', '~> 4.2'
end
