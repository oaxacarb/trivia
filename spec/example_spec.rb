require 'spec_helper'
require 'ugly_trivia/game'

class Juego < UglyTrivia::Game
  attr_reader :players, :places, :purses, :in_penalty_box, :current_player,
      :is_getting_out_of_penalty_box, :pop_questions, :science_questions,
      :sports_questions, :rock_questions
end

describe "Juego" do
  let(:game) { Juego.new }
  
  describe "constructor" do
      it { expect(game.players).to eq([]) }     
      it { expect(game.places).to eq([0,0,0,0,0,0]) }
      it { expect(game.purses).to eq([0,0,0,0,0,0]) }
      it { expect(game.in_penalty_box).to eq([nil,nil,nil,nil,nil,nil]) }
      it { expect(game.current_player).to eq(0) }
      it { expect(game.is_getting_out_of_penalty_box).to eq(false) }
      it { expect(game.pop_questions.size).to eq(50) }
      it { expect(game.science_questions.size).to eq(50) }
      it { expect(game.sports_questions.size).to eq(50) }
      it { expect(game.rock_questions.size).to eq(50) }
  end
  
  describe "#add" do
    it "agrega a jugador a arreglo players" do
      game.add('Jugador 1')
      expect(game.players).to match_array ['Jugador 1']
    end

    it "agrega dos jugadores a arreglo players" do
      game.add('Jugador 1')
      game.add('Jugador 2')
      expect(game.players).to match_array ['Jugador 1', 'Jugador 2' ]
    end
  end
end


describe "UglyTrivia Game" do
  let(:game) { UglyTrivia::Game.new }

  describe "#how_many_players" do
    it "juego nuevo, no tiene jugadores" do
      expect(game.how_many_players).to eq(0)
    end

    it "con un jugador devuelve 1" do
      expect(game.add('Jugador')).to be_true
      expect(game.how_many_players).to eq(1)
    end
    
    it "con dos jugadores devuelve 2" do
      game.add('Jugador 1')
      game.add('Jugador 2')
      expect(game.how_many_players).to eq(2)
    end
  end
  
  describe "#is_playable?" do
    it "devuelve false sin jugadores" do
      expect(game.is_playable?).not_to be_true
    end
    
    it "devuelve false con menos de 2 jugadores" do
      game.add('Jugador 1')
      expect(game.is_playable?).not_to be_true
    end

    it "devuelve true con 2 jugadores" do
      game.add('Jugador 1')
      game.add('Jugador 2')
      expect(game.is_playable?).to be_true
    end
   
    it "devuelve true con mas de 2 jugadores" do
      game.add('Jugador 1')
      game.add('Jugador 2')
      game.add('Jugador 3')
      expect(game.is_playable?).to be_true
    end
  end
  
  describe "#create_rock_question" do
      it 'agrega rock question con indice' do
	  index = 0
	  expect(game.create_rock_question(index)).to eq("Rock Question 0")
      end
  end
  
  describe "#wrong_answer" do 
    it "regresa true" do
      expect(game.wrong_answer).to be_true
    end
  end
end