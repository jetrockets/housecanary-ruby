# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'housecanary/version'

Gem::Specification.new do |spec|
  spec.name = 'housecanary-ruby'
  spec.version = Housecanary::VERSION
  spec.authors = ['Ilia Kriachkov']
  spec.email = ['ilia.kriachkov@jetrockets.ru']

  spec.summary = 'Ruby wrapper for the HouseCanary Data & Analytics API.'
  spec.description = 'Ruby wrapper for the HouseCanary Data & Analytics API. https://www.housecanary.com/real-estate-data-api'
  spec.homepage = 'https://github.com/jetrockets/housecanary-ruby'
  spec.license = 'MIT'

  spec.bindir = 'bin'
  spec.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.7'

  # a b c d e f g h i j k l m n o p q r s t u v w x y z
  spec.add_dependency 'dry-auto_inject'
  spec.add_dependency 'dry-container'
  spec.add_dependency 'dry-initializer'
  spec.add_dependency 'dry-types'
  spec.add_dependency 'http', '~> 5.0.1'

  spec.add_development_dependency 'bundler', '>= 2.0'
  # spec.add_development_dependency 'factory_bot'
  # spec.add_development_dependency 'faker', '~> 1.9'
  spec.add_development_dependency 'pry', '~> 0.11.3'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'simplecov', '>= 0.6.2'
  spec.add_development_dependency 'webmock', '~> 3.4'
end
