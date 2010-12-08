# rails_db_dump

An install-and-forget KISSy wrapper around your database dumper.

## Usage

    rake db:dump

Without parameters the task dumps the current database to standard output.

Pass a `TABLE_NAME` environment variable to dump a single table:

    rake db:dump TABLE_NAME=locations

There is also a symmetrical task, `rake db:restore`, which restores the database from standard input.

## Installation

Rails 3: add `gem rails_db_dump` to your Gemfile.

Rails 2.3: add the gem to your environment, then add `include 'rails_db_dump/tasks'` to your Rakefile

## Requirements

None (except Rails, obviously). Supports MySQL, PostgreSQL, SQLite.

## Tips

The thought behind this plugin was to do one thing and do it good, and that is reuse the existings database settings to provide database dumping functionality.

If you want a complet-er backup solution, pipe it up to `gzip` then add timestamps:

    rake db:dump RAILS_ENV=production | gzip > db/backup/`date +%Y-%m-%d_%H-%M`.sql.gz
   
Only keep the last 5 dumps:

    cd dumps && ls -t | awk 'NR>5' | xargs rm

Push'em home with `scp`:

    scp -r dumps my_secure_backup_server.com:/my/backup/location
    
Or use `rsnapshot` to rotate backups.

* * *

&copy; 2010 Leonid Shevtsov, released under the MIT license
