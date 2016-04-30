class PenaltyBox
  attr_accessor :getting_out

  def add(player)
    players << player
  end

  def in_penalty_box?(player)
    players.include? player
  end
  
  def remove(player)
    players.delete(player)
  end

  def getting_out?
    @getting_out
  end

  private

  def players
    @players ||= []
  end
end
