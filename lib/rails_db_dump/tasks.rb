namespace :db do
  task :dump do
    require 'yaml'
    config = YAML.load_file(File.join(Rails.root,'config','database.yml'))[Rails.env]
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

      exec('mysqldump', *args)

    when "postgresql"
      ENV['PGUSER']     = config["username"] if config["username"]
      ENV['PGHOST']     = config["host"] if config["host"]
      ENV['PGPORT']     = config["port"].to_s if config["port"]
      ENV['PGPASSWORD'] = config["password"].to_s if config["password"]
      exec('pg_dump', config["database"])

    when "sqlite"
      exec('sqlite', config["database"], '.dump')

    when "sqlite3"
      exec('sqlite3', config['database'], '.dump')

    else
      abort "Don't know how to dump #{config['database']}."
    end
  end
end
