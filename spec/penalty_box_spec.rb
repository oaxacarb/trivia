require 'spec_helper'
require 'penalty_box'

describe "PenaltyBox" do
  describe "#in_penalty_box?" do
    it "devuelve true cuando el jugador está en penalty_box" do
      player = Object.new
      @penalty_box = PenaltyBox.new
      @penalty_box.add(player)
      expect(@penalty_box.in_penalty_box?(player)).to be true
    end

    it "devuelve false cuando el jugador no está en penalty_box" do
      player = Object.new
      @penalty_box = PenaltyBox.new
      expect(@penalty_box.in_penalty_box?(player)).to be false
    end

    it "devuelve false cuando el jugador solicitado no está en penalty_box" do
      player_1 = Object.new
      player_2 = Object.new
      @penalty_box = PenaltyBox.new
      @penalty_box.add(player_1)
      expect(@penalty_box.in_penalty_box?(player_2)).to be false
    end
  end
  
  describe '#remove' do
    it 'Remove a player of penalty_box' do
      player = Object.new 
      @penalty_box = PenaltyBox.new
      @penalty_box.add(player)
      @penalty_box.remove(player)
      expect(@penalty_box.in_penalty_box?(player)).to be false 
    end
  end

  describe 'getting_out?' do
     it 'debe ser true cuando se le asigna true' do
       @penalty_box = PenaltyBox.new
       @penalty_box.getting_out = true
       expect(@penalty_box.getting_out?).to be true
     end

     it 'debe ser false cuando se le asigna false' do
       @penalty_box = PenaltyBox.new
       @penalty_box.getting_out = false
       expect(@penalty_box.getting_out?).to be false
     end
  end # describe 'getting_out_of_penalty_box?'
end
