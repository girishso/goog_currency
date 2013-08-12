# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'goog_currency/version'

Gem::Specification.new do |gem|
  gem.name          = "goog_currency"
  gem.version       = GoogCurrency::VERSION
  gem.authors       = ["Girish S"]
  gem.email         = ["girish.sonawane@gmail.com"]
  gem.description   = %q{Ruby Gem for currency conversion using Google API}
  gem.summary       = %q{Simple Ruby interface to Google Currency API}
  gem.add_runtime_dependency 'rest-client'
  gem.add_runtime_dependency 'json'
  
  gem.add_development_dependency "rspec", "~> 2.12.0"
  gem.add_development_dependency "fakeweb", "~> 1.3.0"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
