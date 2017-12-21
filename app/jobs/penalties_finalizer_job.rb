class PenaltiesFinalizerJob < ApplicationJob
  queue_as :default

  def perform(match)
    active_penalties = Penalty.find_by(status: 1)
    active_penalties.each do |p|
      #penalty.starting_match.order + penalty.length == el_match_que_inserte.order (ver si seria >=)
      if p.match.order + p.length >= match.order
        p.status = 2    # Inactivate
        p.save!
      end
    end
  end
end
