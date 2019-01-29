class Incidence < ApplicationRecord
  belongs_to :player
  belongs_to :match

  after_save :process_incidences, on: :create

  def self.incidences_for_player_id_and_incidence_type(player_id, card_type)
    return Incidence.where(status: 1).where(incidence_type: card_type).where(player_id: player_id)
  end

  protected
  def process_incidences
    yellows = []
    reds = []
    yellows = calculate_cards(1)
    reds = calculate_cards(2)
    puts "Yellows: #{yellows}"
    puts "Reds: #{reds}"

    create_penalties_for_yellow_cards yellows
    create_penalties_for_red_cards reds
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

  def create_penalties_for_yellow_cards(yellows)
    puts "Yellows size: #{yellows.size}"
    yellows.each do |player, cards|
      if cards > 1
        # Create Penalty model
        incidences = Incidence.incidences_for_player_id_and_incidence_type(player.id, 1).order(:match_id)
        puts "Got incidences: #{incidences}"
        # I need the Incidence of the last match to create the Penalty
        penalty = Penalty.create(
          player_id: player.id,
          match_id: incidences.last.match.id,
          length: 1,    # Yellow card has one match only
          status: 1
        )
        # Deactivate Incidences for this Player
        incidences.each do |i|
          i.status = 2    # 2 is inactive
          i.save!
        end
      end
    end
  end

  # TODO remove duplication here
  # Pass a Block with common behaviour? Pass the condition as parameter?
  def create_penalties_for_red_cards(reds)
    puts "Reds size: #{reds.size}"
    reds.each do |player, cards|
      if cards > 0
        # Create Penalty model
        # penalty = Penalty.create :player_id => p.id, :status => "active"
        # Deactivate Incidences for this Player
        incidences = Incidence.incidences_for_player_id_and_incidence_type(player.id, 2).order(:match_id)
        penalty = Penalty.create(
          player_id: player.id,
          match_id: incidences.last.match.id,
          length: 2,    # Red card has two matches (for now)
          status: 1
        )
        # Deactivate Incidences for this Player
        incidences.each do |i|
          i.status = 2    # 2 is inactive
          i.save!
        end
      end
    end
  end

end
