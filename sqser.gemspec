# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sqser/version'

Gem::Specification.new do |gem|
  gem.name          = "sqser"
  gem.version       = Sqser::VERSION
  gem.authors       = ["Brett Weaver"]
  gem.email         = ["brett@weav.net"]
  gem.description   = %q{Library to queue and execute jobs via AWS SQS}
  gem.summary       = %q{Library to queue and execute jobs via AWS SQS}
  gem.homepage      = "https://github.com/brettweavnet/sqser"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"

  gem.add_runtime_dependency "aws-sdk"
end
