class Board
  attr_reader :places

  def initialize(places)
    @places = places
  end

  def place(player)
    @places[player] 
  end
  
  def move(player, roll)
      @places[player] += roll
      @places[player] -= 12 if @places[player] >= 12
  end
end