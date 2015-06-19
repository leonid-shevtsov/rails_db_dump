namespace :db do
  desc "Dump the database to standard output. Pass a TABLE_NAME environment variable to dump a single table"
  task :dump => :environment do
    config = Rails.configuration.database_configuration[Rails.env]
    table_name = ENV['TABLE_NAME']

    case config["adapter"]
    when /^mysql/
      args = {
        'host'      => '--host',
        'port'      => '--port',
        'socket'    => '--socket',
        'username'  => '--user',
        'encoding'  => '--default-character-set',
        'password'  => '--password'
      }.map { |opt, arg| "#{arg}=#{config[opt]}" if config[opt] }.compact
      args << config['database']
      args << table_name unless table_name.blank?

      exec('mysqldump', *args)

    when "postgresql"
      ENV['PGUSER']     = config["username"] if config["username"]
      ENV['PGHOST']     = config["host"] if config["host"]
      ENV['PGPORT']     = config["port"].to_s if config["port"]
      ENV['PGPASSWORD'] = config["password"].to_s if config["password"]
      if table_name.blank?
        exec('pg_dump', config["database"])
      else
        exec('pg_dump', '-t', table_name, config["database"])
      end

    when "sqlite"
      raise 'Table dumping not supported with sqlite... yet' unless table_name.blank?
      exec('sqlite', config["database"], '.dump')

    when "sqlite3"
      raise 'Table dumping not supported with sqlite... yet' unless table_name.blank?
      exec('sqlite3', config['database'], '.dump')

    else
      abort "Don't know how to dump #{config['database']}."
    end
  end

  desc "Restore the database from standard input."
  task :restore do
    if Rails.version > '3'
      exec 'rails', 'dbconsole', '--include-password'
    else
      exec File.join(Rails.root, 'script', 'dbconsole'), '--include-password'
    end
  end
end
