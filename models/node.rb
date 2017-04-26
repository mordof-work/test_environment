class Node < ApplicationRecord
  if ENV['TEST'].present?


    ######################
    #
    #  When this is commented out, there is no 'stack level too deep'
    #  issue.
    #
    ######################

    has_one :agency
  end
end
