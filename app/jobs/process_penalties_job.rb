class ProcessPenaltiesJob < ApplicationJob
  queue_as :default

  def perform(*cards)
    yellows = cards[0]
    puts "yellows: #{yellows}"
    reds = cards[1]
    puts "reds: #{reds}"
    create_penalties_for_yellow_cards(yellows)
    create_penalties_for_red_cards(reds)
  end

  def create_penalties_for_yellow_cards(yellows)
    yellows.each do |player_id, cards|
      id = player_id.to_i
      if cards > 1
        # Create Penalty model
        incidences = Incidence.incidences_for_player_id_and_incidence_type(id, 1).order(:match_id)
        # I need the Incidence of the last match to create the Penalty
        penalty = Penalty.create(
          player_id: id,
          match_id: incidences.last.match_id,
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
    reds.each do |player_id, cards|
      id = player_id.to_i
      if cards > 0
        # Create Penalty model
        # penalty = Penalty.create :player_id => p.id, :status => "active"
        # Deactivate Incidences for this Player
        incidences = Incidence.incidences_for_player_id_and_incidence_type(id, 2).order(:match_id)
        penalty = Penalty.create(
          player_id: id,
          match_id: incidences.last.match_id,
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
