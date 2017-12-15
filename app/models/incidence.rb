class Incidence < ApplicationRecord
  belongs_to :player
  belongs_to :match

  def self.incidences_for_player_id_and_incidence_type(player_id, card_type)
    return Incidence.where(status: 1).where(incidence_type: card_type)
  end
end
