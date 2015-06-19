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
  s.summary     = %q{Dump your Rails database with a simple rake task}
  s.description = <<-EOT
Adds a Rake command to dump and restore the application's database.

Delegates to regular dumping utilities such as `mysqldump` and `pg_dump`. Unlike them, you *don't* have to remember any proper syntax.

You don't have to specify the connection parameters either; if the application works the dumper works, too.
EOT
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
