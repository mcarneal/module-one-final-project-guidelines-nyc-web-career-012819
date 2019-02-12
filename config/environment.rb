require 'bundler'
Bundler.require
require 'dotenv/load'
require 'http'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
require_all 'app'
