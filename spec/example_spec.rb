require 'spec_helper'
require 'ugly_trivia/game'

class Juego < UglyTrivia::Game
  attr_reader :players, :places, :purses, :in_penalty_box,
       :pop_questions, :science_questions,
      :sports_questions, :rock_questions
  attr_accessor :current_player, :in_penalty_box, :is_getting_out_of_penalty_box
  
  def did_player_win
    super 
  end
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
    context "con un jugador" do
      before(:each) do
        game.add('Jugador 1')
      end
      it { expect(game.players).to match_array ['Jugador 1'] }
      it { expect(game.in_penalty_box[1]).to be false }
      it { expect(game.places[1]).to eq(0) }
      it { expect(game.purses[1]).to eq(0) }
    end  

    context "con dos jugadores" do
      before(:each) do
        2.times{|i| game.add("Jugador #{i+1}")}
      end
      it { expect(game.players).to match_array ['Jugador 1', 'Jugador 2'] }
      it { expect(game.in_penalty_box[2]).to be false }
      it { expect(game.places[2]).to eq(0) }
      it { expect(game.purses[2]).to eq(0) }
    end  
    
    context "con seis jugadores" do
      before(:each) do
        6.times{|i| game.add("Jugador #{i+1}")}
      end
      it { expect(game.players).to match_array ['Jugador 1', 'Jugador 2', 'Jugador 3', 'Jugador 4', 'Jugador 5', 'Jugador 6'] }
      it { expect(game.in_penalty_box[6]).to be false }
      it { expect(game.places[6]).to eq(0) }
      it { expect(game.purses[6]).to eq(0) }
    end  
  end # describe add
  
  describe "#was_correctly_answered" do
    context 'penalty box' do
      let(:current_player) { game.current_player = 1 }
      context 'fuera del penalty box' do
	before { game.in_penalty_box[current_player] = false } 
	it "incrementa purses" do
	    game.was_correctly_answered
	    expect(game.purses[current_player]).to eq(1)
	end
	context 'did_player_win es true' do
	  # NOTE: Esta sintaxis es para rspec 3
	  # before { allow(game).to receive(:did_player_win).and_return(true) }
	  before { game.stub did_player_win: true }
	  it 'regresa true' do
	    result = game.was_correctly_answered
	    expect(result).to be_true
	  end
	end
	context 'did_player_win es false' do
	  before { game.stub did_player_win: false }
	  it 'regresa false' do
	    result = game.was_correctly_answered
	    expect(result).to be_false
	  end
	end
      end
      context 'dentro de penalty box' do
	before { game.in_penalty_box[current_player] = true } 
	context 'is_getting_out_of_penalty_box cuando es true' do
	  before { game.is_getting_out_of_penalty_box = true }
	  it "incrementa purses" do
	    game.was_correctly_answered
	    expect(game.purses[current_player]).to eq(1)
	  end
	  
	  context 'did_player_win es true' do
	    before { game.stub did_player_win: true }
	    it 'regresa true' do
	      result = game.was_correctly_answered
	      expect(result).to be_true
	    end
	  end
	  context 'did_player_win es false' do
	    before { game.stub did_player_win: false }
	    it 'regresa false' do
	      result = game.was_correctly_answered
	      expect(result).to be_false
	    end
	  end
	end # context is_getting_out_of_penalty_box = true
	
	context 'is_getting_out_of_penalty_box cuando es falso' do
	  before { game.is_getting_out_of_penalty_box = false }
	  it "regresa true" do
	    result = game.was_correctly_answered
	    expect(result).to eq(true)
	  end
	end
      end # context dentro del penalty box
    end # context penalty box
    
    it "incrementa current_player en 1 cuando se tienen 3 jugadores y current player es 0" do
      3.times{|i| game.add("Jugador #{i+1}")}
      game.current_player = 0
      expect {
	game.was_correctly_answered
      }.to change{ game.current_player }.by 1
    end
    
    it "incrementa current_player en 1 cuando se tienen 3 jugadores y current player es 1" do
      3.times{|i| game.add("Jugador #{i+1}")}
      game.current_player = 1
      expect {
	game.was_correctly_answered
      }.to change{ game.current_player }.by 1
    end
    
    it "reinicia current_player a 0 cuando se tienen 3 jugadores y current player es 2" do
      3.times{|i| game.add("Jugador #{i+1}")}
      game.current_player = 2
      game.was_correctly_answered
      expect(game.current_player).to eq 0
    end
  end # describe #was_correctly_answered
  
  describe "#wrong_answer" do
    it "Modificar in_penalty_box de current_player a true " do
      game.current_player = 1
      game.wrong_answer
      expect(game.in_penalty_box[1]).to eq true
    end
    
    it "incrementa current_player en 1 cuando se tienen 3 jugadores y current player es 0" do
      3.times{|i| game.add("Jugador #{i+1}")}
      game.current_player = 0
      expect {
	game.wrong_answer
      }.to change{ game.current_player }.by 1
    end
    
    it "incrementa current_player en 1 cuando se tienen 3 jugadores y current player es 1" do
      3.times{|i| game.add("Jugador #{i+1}")}
      game.current_player = 1
      expect {
	game.wrong_answer
      }.to change{ game.current_player }.by 1
    end
    
    it "reinicia current_player a 0 cuando se tienen 3 jugadores y current player es 2" do
      3.times{|i| game.add("Jugador #{i+1}")}
      game.current_player = 2
      game.wrong_answer
      expect(game.current_player).to eq 0
    end
  end # describe #wrong_answer
  
  describe "#did_player_win" do
    let(:current_player) { game.current_player = 1 }
    it 'Cuando purses en la posición current_player es menor a 6 regresa true' do
	game.purses[current_player] = 1
        result = game.did_player_win
	expect(result).to eq(true)
    end
    it 'Cuando purses en la posición current_player es igual a 6 regresa false' do
        game.purses[current_player] = 6
        result = game.did_player_win
	expect(result).to eq(false)
    end
    it 'Cuando purses en la posición current_player es mayor a 6 regresa true' do
        game.purses[current_player] = 7
        result = game.did_player_win
	expect(result).to eq(true)
    end
  end
  
  describe "#roll" do
    let(:current_player) { game.current_player = 1 }
    context "in_penalty_box true" do
      before { game.in_penalty_box[current_player] = true } 
      context "parámetro roll es par" do
	let(:roll) { 2 }
	it "is_getting_out_of_penalty_box es falso" do
	  game.roll(roll) 
	  expect(game.is_getting_out_of_penalty_box).to be_false
	end
      end
      
      context "parámetro roll es impar" do
	let(:roll) { 3 }
	it "is_getting_out_of_penalty_box es true" do
	  game.roll(roll) 
	  expect(game.is_getting_out_of_penalty_box).to be_true
	end
	context 'cuando places en current_player + roll es menor a 12 mantiene el valor' do
	  it 'valor inicial 8' do
	    game.places[current_player] = 8
	    game.roll(roll)
	    expect(game.places[current_player]).to eq(11)
	  end
	  it 'valor inicial 2' do
	    game.places[current_player] = 2
	    game.roll(roll)
	    expect(game.places[current_player]).to eq(5)
	  end
	end # context
	context 'cuando places en current_player + roll es mayor o igual a 12 le resta 12' do
	  it 'valor inicial 9' do
	    game.places[current_player] = 9
	    game.roll(roll)
	    expect(game.places[current_player]).to eq(0)
	  end
	  
	  it 'valor inicial 11' do
	    game.places[current_player] = 11
	    game.roll(roll)
	    expect(game.places[current_player]).to eq(2)
	  end
	end # context
      end
    end
    context "in_penalty_box false" do
      before { game.in_penalty_box[current_player] = false } 
      let(:roll) { 3 }
      context 'cuando places en current_player + roll es menor a 12 mantiene el valor' do
	it 'valor inicial 8' do
	  game.places[current_player] = 8
	  game.roll(roll)
	  expect(game.places[current_player]).to eq(11)
	end
	it 'valor inicial 2' do
	  game.places[current_player] = 2
	  game.roll(roll)
	  expect(game.places[current_player]).to eq(5)
	end
      end # context
      context 'cuando places en current_player + roll es mayor o igual a 12 le resta 12' do
	it 'valor inicial 9' do
	  game.places[current_player] = 9
	  game.roll(roll)
	  expect(game.places[current_player]).to eq(0)
	end
	
	it 'valor inicial 11' do
	  game.places[current_player] = 11
	    game.roll(roll)
	    expect(game.places[current_player]).to eq(2)
	  end
      end # context
    end # context in penalty box = false
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