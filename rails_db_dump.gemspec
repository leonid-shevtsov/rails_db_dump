# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rails_db_dump/version"

Gem::Specification.new do |s|
  s.name        = "rails_db_dump"
  s.version     = RailsDbDump::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Leonid Shevtsov"]
  s.email       = ["leonid@shevtsov.me"]
  s.homepage    = "https://github.com/leonid-shevtsov/rails_db_dump"
  s.summary     = %q{dump your Rails database with a simple rake task}
  s.description = %q{rails_db_dump is a wrapper for the native dumper of whatever database engine you're using, taking access parameters from database.yml. Supports mysql, postgresql and sqlite at the moment.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
