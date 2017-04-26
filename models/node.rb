class Node < ApplicationRecord
  ######################
  #
  #  When this is commented out, there is no 'stack level too deep'
  #  issue.
  #
  ######################

  has_one :agency
  has_one :client
  has_one :presence
end
