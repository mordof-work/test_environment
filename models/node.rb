class Node < ApplicationRecord
  ######################
  #
  #  When this is commented out, there is no 'stack level too deep'
  #  issue.
  #
  ######################

  has_one :agency, inverse_of: :node
  has_one :client, inverse_of: :node
  has_one :presence, inverse_of: :node
end
