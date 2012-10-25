# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hostesse/version'

Gem::Specification.new do |gem|
  gem.name          = 'hostesse'
  gem.version       = Hostesse::VERSION
  gem.authors       = ['Leandro Facchinetti']
  gem.email         = ['leafac@gmail.com']
  gem.description   = %q{Hosts manager}
  gem.summary       = %q{Define hosts using a template engine and change between them easily}

  #TODO: add homepage
  gem.homepage      = ''

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
  gem.add_dependency 'listen', '~> 0.5.3'
end
