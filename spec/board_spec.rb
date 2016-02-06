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
    let(:usuario_actual){ 1 }
    
    context "para posicion final menor a 12" do
        it "mueve al usuario_actual, 5 casillas empezando desde 0" do
            board = Board.new([1,0,3])
            board.move(usuario_actual,5)
            expect(board.place(usuario_actual)).to eq 5
        end
        
        it "mueve al usuario_actual, 2 casillas empezando desde 0" do
            board = Board.new([1,0,3])
            board.move(usuario_actual,2)
            expect(board.place(usuario_actual)).to eq 2
        end
        
        it "mueve al usuario_actual, 3 casillas empezando desde 1" do
            board = Board.new([1,1,3])
            board.move(usuario_actual,3)
            expect(board.place(usuario_actual)).to eq 4
        end

    end
    
    context "para posicion final mayor o igual a 12" do
        it "mueve al usuario_actual, 1 casilla empezando en 11 regresa a 0" do
            board = Board.new([1,11,3])
            board.move(usuario_actual,1)
            expect(board.place(usuario_actual)).to eq 0
        end
        
        it "mueve al usuario_actual, 2 casillas empezando en 11 regresa a 1" do
            board = Board.new([1,11,3])
            board.move(usuario_actual,2)
            expect(board.place(usuario_actual)).to eq 1
        end
    end
  end
  
end
