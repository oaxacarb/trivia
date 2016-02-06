require 'spec_helper'
require 'board'

describe "Board" do
  describe "#place" do
    let(:board) { Board.new([0,6,8,3]) }
    
    it "devuelve el lugar actual de jugador 3" do
      player = 3
      expect(board.place(player)).to eq 3
    end
    
    it "devuelve el lugar actual de jugador 2" do
      player = 2
      expect(board.place(player)).to eq 8
    end

    it "devuelve el lugar actual de jugador 1" do
      player = 1
      expect(board.place(player)).to eq 6
    end
    
  end

  describe "#places" do
    it "devuelve el arreglo places [0,6,8]" do
      board = Board.new([0, 6, 8])
      expect(board.places).to eq [0, 6, 8]
    end
      
    it "devuelve el arreglo places [1,2,3]" do
      board = Board.new([1,2,3])
      expect(board.places).to eq [1,2,3]   
    end
  end

  describe "#move" do
    it "" do
    end
  end
  
end
