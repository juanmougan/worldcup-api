class Round < ActiveRecord::Base
  enum status: [ :first_round, :sixteen, :quarter, :semifinal, :third_place, :final ]
end
