require 'require_all'
require_all 'init.rb'

if ENV['USE_FACTORY_GIRL'].present?
  presence = FactoryGirl.create :presence
else
  agency = Agency.create name: "agency"
  client = Client.create name: "client", agency_id: agency.id
  presence = Presence.create name: "presence", client_id: client.id
end

binding.pry if ENV['DEBUG'].present?

puts "foo"
