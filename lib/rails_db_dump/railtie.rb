require 'rails_db_dump'
require 'rails'

module RailsDbDump
  class Railtie < Rails::Railtie
    rake_tasks do
      load File.expand_path('../tasks.rb', __FILE__)
    end
  end
end
