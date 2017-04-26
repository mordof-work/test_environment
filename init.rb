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

if ENV['USE_FACTORY_GIRL'].present?
  FactoryGirl.define do
    factory :agency do
      name { "agency" }
    end

    factory :client do
      agency
      name { "client name" }
    end

    factory :presence do
      client
      name { "presence name" }
    end
  end
end
