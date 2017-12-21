class Match < ApplicationRecord
  belongs_to :home_team, :class_name => 'Team', :foreign_key => 'home_team'
  belongs_to :away_team, :class_name => 'Team', :foreign_key => 'away_team'

  after_save :process_incidences, on: :create

  protected
  def process_incidences
    ProcessBookedPlayers.perform_later guest
    PenaltiesFinalizerJob.perform_later self
  end

end
