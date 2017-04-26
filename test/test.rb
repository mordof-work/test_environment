require 'require_all'
require_all 'init.rb'

Agency.delete_all
Client.delete_all
Presence.delete_all
Node.delete_all


agency = Agency.create name: "agency"
client = Client.create name: "client", agency_id: agency.id
presence = Presence.create name: "presence", client_id: client.id

binding.pry if ENV['DEBUG'].present?

puts "foo"
