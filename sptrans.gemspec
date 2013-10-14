# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sptrans/version'

Gem::Specification.new do |spec|
  spec.name          = "sptrans"
  spec.version       = Sptrans::VERSION
  spec.authors       = ["@paulopatto"]
  spec.email         = ["paulopatto@gmail.com"]
  spec.description   = %q{Gem para acessoa a API do serviço Olho vivo da SPTrans}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = "http://olhovivo.sptrans.com.br"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty"
  spec.add_dependency "geocoder"
  spec.add_dependency "hashie"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
