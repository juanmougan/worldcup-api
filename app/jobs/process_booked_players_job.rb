class ProcessBookedPlayersJob < ApplicationJob
  queue_as :default
  @cards = []

  def perform(*args)
    @cards = []
    yellows = calculate_cards(1)
    reds = calculate_cards(2)
    @cards << yellows << reds
  end

  def after_perform(*match)
    #PenaltiesFinalizerJob.perform_later match
    ProcessPenalties.perform_later @cards
    PenaltiesFinalizer.perform_later match
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
