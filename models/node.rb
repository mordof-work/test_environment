class Node < ApplicationRecord
  if ENV['TEST'].present?


    ######################
    #
    #  When these three are commented out, there is no 'stack level too deep'
    #  issue.
    #
    ######################

    has_one :agency
    has_one :client
    has_one :presence
  end
end
