require 'bundler'
Bundler.require
require 'dotenv/load'
require 'http'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
#ActiveRecord::Base.logger.level = 1

require_all 'app'
require_all 'lib'
