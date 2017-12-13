class IncidenceDetail < ApplicationRecord
  enum incidence: [ :yellow_card, :red_card ]
end
