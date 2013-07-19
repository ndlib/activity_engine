$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "satchel/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "satchel"
  s.version     = Satchel::VERSION
  s.authors     = [
    "Jeremy Friesen"
  ]
  s.email       = [
    "jeremy.n.friesen@gmail.com"
  ]

  s.homepage    = "http://github.com/ndlib/satchel"
  s.summary     = "Satchel - a mountable Rails engine for activity streams"
  s.description = "Satchel - a mountable Rails engine for activity streams"
  s.license = "APACHE2"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rails", "~> 3.2.13"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'rspec-rails'
end
