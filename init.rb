require 'rubygems'
require 'bundler'
require 'require_all'
Bundler.require

require 'active_record'

ActiveRecord::Base.default_timezone = :utc
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  encoding: 'unicode',
  database: 'test_circular',
  username: 'mordof',
  host: '127.0.0.1',
  pool: 5
)

require_all 'models/application_record.rb'
require_all 'models'
