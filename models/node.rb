class Node < ApplicationRecord
  ######################
  #
  #  When this is commented out, there is no 'stack level too deep'
  #  issue.
  #
  ######################

  has_one :agency
end
