# -*- encoding: utf-8 -*-
require File.expand_path('../lib/redismq/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Michael Gorsuch"]
  gem.email         = ["michael.gorsuch@gmail.com"]
  gem.description   = %q{A cheap and naive implementation of topic exchanges on top of Redis.}
  gem.summary       = %q{A cheap and naive implementation of topic exchanges on top of Redis.}
  gem.homepage      = "https://github.com/gorsuch/redismq"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "redismq"
  gem.require_paths = ["lib"]
  gem.version       = RedisMQ::VERSION
  gem.add_dependency('json')
  gem.add_dependency('redis', '2.2.2')
end
