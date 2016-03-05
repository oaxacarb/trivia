require 'spec_helper'
require 'ugly_trivia/game'

class Juego < UglyTrivia::Game
  attr_reader :players, :purses, :in_penalty_box,
    :pop_questions, :science_questions,
    :sports_questions, :rock_questions, :buffer
  attr_accessor :current_player, :in_penalty_box, :is_getting_out_of_penalty_box
  
  def places
    @board.places
  end

  def did_player_win
    super
  end

  def ask_question
    super
  end

  def puts(str)
    @buffer ||= ""
    @buffer << str
    Kernel.puts str 
  end

  def test_puts(str)
    puts(str)
  end

  public :current_category
end

describe "Juego" do
  let(:game) { Juego.new }

  describe "#puts" do
    it 'stores the system output' do
      game.test_puts "MyTest"
      expect(game.buffer).to include("MyTest")
    end
  end

  describe "constructor" do
    it { expect(game.players).to eq([]) }     
    it { expect(game.places).to eq([0,0,0,0,0,0]) }
    it { expect(game.purses).to eq([0,0,0,0,0,0]) }
    it { expect(game.in_penalty_box).to eq([false,false,false,false,false,false]) }
    it { expect(game.current_player).to eq(0) }
    it { expect(game.is_getting_out_of_penalty_box).to eq(false) }
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

      context "system output" do
        it "player was added" do
          game.add('Jugador 1')
          expect(game.buffer).to include("Jugador 1 was added")
        end

        context "Indicates the number of players" do
          it 'For one player' do 
            game.add('Jugador 1')
            expect(game.buffer).to include("They are player number 1")
          end
          it 'For two players' do 
            game.add('Jugador 1')
            game.add('Jugador 2')
            expect(game.buffer).to include("They are player number 1")
            expect(game.buffer).to include("They are player number 2")	  
          end
        end

      end

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

        it "system output" do
          game.was_correctly_answered 
          expect(game.buffer).to include("Answer was correct!!!!")
        end

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
            expect(result).to be true
          end
        end

        context 'did_player_win es false' do
          before { game.stub did_player_win: false }
          it 'regresa false' do
            result = game.was_correctly_answered
            expect(result).to be false
          end
        end
      end

      context 'dentro de penalty box' do
        before { game.in_penalty_box[current_player] = true } 

        context 'is_getting_out_of_penalty_box cuando es true' do
          before { game.is_getting_out_of_penalty_box = true }

          context "system output" do
            it "Answer was correct" do
              game.was_correctly_answered 
              expect(game.buffer).to include("Answer was correct!!!!")
            end

            it "now has 1 Gold Coins." do
              game.was_correctly_answered 
              expect(game.buffer).to include("now has 1 Gold Coins.")
            end
          end

          it "incrementa purses" do
            game.was_correctly_answered
            expect(game.purses[current_player]).to eq(1)
          end

          context 'did_player_win es true' do
            before { game.stub did_player_win: true }
            it 'regresa true' do
              result = game.was_correctly_answered
              expect(result).to be true
            end

            it "now has 1 Gold Coins." do
              game.was_correctly_answered 
              expect(game.buffer).to include("now has 1 Gold Coins.")
            end
          end

          context 'did_player_win es false' do
            before { game.stub did_player_win: false }
            it 'regresa false' do
              result = game.was_correctly_answered
              expect(result).to be false
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

    it "puts Question was incorrectly answered" do
      game.wrong_answer
      expect(game.buffer).to include("Question was incorrectly answered")
    end

    it "was sent to the penalty box" do
      game.wrong_answer
      expect(game.buffer).to include("was sent to the penalty box")
    end    

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

      context 'system output' do 
        it 'They have rolled a' do 
          game.roll(2)
          expect(game.buffer).to include('They have rolled a 2')
        end

        context 'is the current player' do
          it 'is the current player' do 
            game.roll(1)
            expect(game.buffer).to include('is the current player')
          end

          it 'jugador 1  is the current player' do
            game.current_player = 0 
            game.add('jugador 1')
            game.roll(1)
            expect(game.buffer).to include('jugador 1 is the current player')
          end
        end
      end

      context "parámetro roll es par" do
        let(:roll) { 2 }
        it "is_getting_out_of_penalty_box es falso" do
          game.roll(roll) 
          expect(game.is_getting_out_of_penalty_box).to be false
        end
      end

      context "parámetro roll es impar" do
        let(:roll) { 3 }
        it "is_getting_out_of_penalty_box es true" do
          game.roll(roll) 
          expect(game.is_getting_out_of_penalty_box).to be true
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

        it "debe llamar a ask_question" do
          game.should_receive(:ask_question).exactly(:once)
          game.roll(roll)
        end
      end # context parámetro impar
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

      it "debe llamar a ask_question" do
        game.should_receive(:ask_question).exactly(:once)
        game.roll(roll)
      end

    end # context in penalty box = false
  end # describe roll

  describe "#ask_question" do
    it "debe probar la salida del método"
  end # describe #ask_question

end

describe "UglyTrivia Game" do
  let(:game) { UglyTrivia::Game.new }

  describe "#how_many_players" do
    it "juego nuevo, no tiene jugadores" do
      expect(game.how_many_players).to eq(0)
    end

    it "con un jugador devuelve 1" do
      expect(game.add('Jugador')).to be true
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
      expect(game.is_playable?).not_to be true
    end

    it "devuelve false con menos de 2 jugadores" do
      game.add('Jugador 1')
      expect(game.is_playable?).not_to be true
    end

    it "devuelve true con 2 jugadores" do
      game.add('Jugador 1')
      game.add('Jugador 2')
      expect(game.is_playable?).to be true
    end

    it "devuelve true con mas de 2 jugadores" do
      game.add('Jugador 1')
      game.add('Jugador 2')
      game.add('Jugador 3')
      expect(game.is_playable?).to be true
    end
  end

  describe "#wrong_answer" do 
    it "regresa true" do
      expect(game.wrong_answer).to be true
    end
  end
end
