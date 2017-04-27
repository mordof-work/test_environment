if ENV['NULLDB']
  class Rails
    def self.root
      "./"
    end

    def self.env
      'test'
    end
  end
end

require 'rubygems'
require 'bundler'

if ENV['NULLDB']
  if ENV['OLD']
    gem 'activesupport', '4.1.5'
    gem 'activemodel', '4.1.5'
    gem 'activerecord', '4.1.5'
  end

  require 'active_record'
end

require 'require_all'
Bundler.require

require 'active_record'

ActiveRecord::Base.default_timezone = :utc
if ENV['NULLDB']
  ActiveRecord::Base.establish_connection adapter: :nulldb, schema: 'schema.rb'
else
  ActiveRecord::Base.establish_connection(
    adapter: 'postgresql',
    encoding: 'unicode',
    database: 'test_circular',
    username: 'mordof',
    host: '127.0.0.1',
    pool: 5
  )
end

require_all 'models/application_record.rb'
require_all 'models'

#########################################
# Actual Code for the Test
#########################################

Agency.delete_all
Client.delete_all
Presence.delete_all
Node.delete_all

begin
  agency = Agency.create name: "agency"
  # client = Client.create name: "client", agency_id: agency.id
  # presence = Presence.create name: "presence", client_id: client.id
rescue Exception => e
  puts e.inspect
  puts e.backtrace
end

binding.pry if ENV['DEBUG'].present?

puts ""

