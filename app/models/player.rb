class Player < ApplicationRecord
  belongs_to :team
  has_many :incidences

  def self.fetch_players_with_active_incidences
    sql = "select p.* from players p " +
      "inner join incidences i on p.id = i.player_id " +
      "where i.status = 1"
      return Player.find_by_sql(sql)
  end

end
