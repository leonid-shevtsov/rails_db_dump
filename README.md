# rails_db_dump

Adds a Rake command to dump and restore the application's database.

Delegates to regular dumping utilities such as `mysqldump` and `pg_dump`. Unlike them, you *don't* have to remember any proper syntax.

You don't have to specify the connection parameters either; if the application works the dumper works, too.

## Usage

    rake db:dump

Without parameters the task dumps the current database to standard output.

Pass a `TABLE_NAME` environment variable to dump a single table:

    rake db:dump TABLE_NAME=locations

There is also a symmetrical task, `rake db:restore`, which restores the database from standard input.

## Requirements

Rails versions 2.3 through 4.2 are tested and supported.

Supported database engines: MySQL, PostgreSQL, SQLite. The command line utilities must be available from the PATH:

* for MySQL - `mysqldump`;
* for PostgreSQL - `pg_dump`;
* for SQLite - `sqlite` or `sqlite3`.

## Installation

Rails 3 and later: add `gem rails_db_dump, '~>1.0.0'` to your Gemfile.

Rails 2.3: add the gem to your environment; add `require 'rails_db_dump/tasks'` to the end of `Rakefile`.

## Integration with other tools

The thought behind this plugin was to do one thing and do it good, and that is reuse the existings database settings to provide database dumping functionality.

If you want a complet-er backup solution, pipe it up to `gzip` then add timestamps:

    rake db:dump RAILS_ENV=production | gzip > db/backup/`date +%Y-%m-%d_%H-%M`.sql.gz
   
Only keep the last 5 dumps:

    cd dumps && ls -t | awk 'NR>5' | xargs rm

Push'em home with `scp`:

    scp -r dumps my_secure_backup_server.com:/my/backup/location
    
Or use `rsnapshot` to rotate backups.

* * *

&copy; 2015 Leonid Shevtsov, released under the MIT license
