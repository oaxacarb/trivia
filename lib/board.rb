class Board
  attr_reader :places

  def initialize(places)
    @places = places
  end

  def place(player)
    @places[player] 
  end
end