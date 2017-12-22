class Incidence < ApplicationRecord
  belongs_to :player
  belongs_to :match

  after_save :process_incidences, on: :create

  def self.incidences_for_player_id_and_incidence_type(player_id, card_type)
    return Incidence.where(status: 1).where(incidence_type: card_type).where(player_id: player_id)
  end

  protected
  def process_incidences
    cards = []
    yellows = calculate_cards(1)
    reds = calculate_cards(2)
    cards << yellows << reds
    ProcessPenaltiesJob.perform_later cards
    PenaltiesFinalizerJob.perform_later self.match
  end

  def calculate_cards(card_type)
    cards = Hash.new
    players = Player.fetch_players_with_active_incidences
    players.each { |p|
      # 1 is yellow, 2 is red
      counted_cards = Incidence.incidences_for_player_id_and_incidence_type(p.id, card_type).size
      cards[p] = counted_cards
    }
    return cards
  end
end
