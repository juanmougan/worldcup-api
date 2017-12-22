class Incidence < ApplicationRecord
  belongs_to :player
  belongs_to :match

  after_save :process_incidences, on: :create

  def self.incidences_for_player_id_and_incidence_type(player_id, card_type)
    return Incidence.where(status: 1).where(incidence_type: card_type).where(player_id: player_id)
  end

  protected
  def process_incidences
    ProcessBookedPlayersJob.perform_later
  end
end
