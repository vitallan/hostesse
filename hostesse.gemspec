# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hostesse/version'

Gem::Specification.new do |gem|
  gem.name          = 'hostesse'
  gem.version       = Hostesse::VERSION
  gem.authors       = ['Leandro Facchinetti']
  gem.email         = ['leafac@gmail.com']
  gem.description   = %q{Templatable hosts manager}
  gem.summary       = %q{Define multiple hosts files for your machine using a templating engine and easily switch between them}

  #TODO: add homepage
  gem.homepage      = ''

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
end
