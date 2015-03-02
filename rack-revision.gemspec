require File.expand_path('../lib/rack/revision/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = "rack-revision"
  s.version     = Rack::Revision::VERSION
  s.summary     = "Code ravision rack middleware"
  s.description = "Adds an extra X-REVISION header with source code revision string (git, svn, etc)"
  s.homepage    = "http://github.com/sosedoff/rack-revision"
  s.authors     = ["Dan Sosedoff"]
  s.email       = ["dan.sosedoff@gmail.com"]

  s.add_runtime_dependency 'rack', '>= 1.0'

  s.add_development_dependency 'rake',      '~> 10.0'
  s.add_development_dependency 'rack-test', '>= 0'
  s.add_development_dependency 'simplecov', '~> 0.8'
  s.add_development_dependency 'test-unit', '>= 0'

  s.files              = `git ls-files`.split("\n")
  s.test_files         = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables        = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  s.require_paths      = ["lib"]
end