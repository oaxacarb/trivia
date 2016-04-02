class PenaltyBox
  def add(player)
    players << player
  end

  def in_penalty_box?(player)
    players.include? player
  end
  
  def remove(player)
    players.delete(player)
  end

  private

  def players
    @players ||= []
  end
end
