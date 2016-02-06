module UglyTrivia
  class Game
    def  initialize
      @players = []
      @board = Board.new(Array.new(6, 0))
      @purses = Array.new(6, 0)
      @in_penalty_box = Array.new(6, nil)
      
      @current_player = 0
      @is_getting_out_of_penalty_box = false      
      create_questions
    end
    
    def is_playable?
      how_many_players >= 2
    end
    
    def add(player_name)
      @players.push player_name
      @board.places[how_many_players] = 0
      @purses[how_many_players] = 0
      @in_penalty_box[how_many_players] = false
      
      puts "#{player_name} was added"
      puts "They are player number #{@players.length}"
      
      true
    end
    
    def how_many_players
      @players.length
    end
    
    def roll(dice_roll)
      puts "#{@players[@current_player]} is the current player"
      puts "They have rolled a #{dice_roll}"
      
      if @in_penalty_box[@current_player]
	      if dice_roll.odd?
	        @is_getting_out_of_penalty_box = true
	        
	        puts "#{@players[@current_player]} is getting out of the penalty box"
	        move_player(dice_roll)
	        puts "#{@players[@current_player]}'s new location is #{current_place}"
	        puts "The category is #{current_category}"
	        ask_question
	      else
	        puts "#{@players[@current_player]} is not getting out of the penalty box"
	        @is_getting_out_of_penalty_box = false
	      end
      else
        move_player(dice_roll)
	      puts "#{@players[@current_player]}'s new location is #{current_place}"
	      puts "The category is #{current_category}"
	      ask_question
      end
    end
    
    def was_correctly_answered
      if @in_penalty_box[@current_player]
      	if @is_getting_out_of_penalty_box
	        answer_was_correct 
	      else
	        next_player 
	        true
	      end
      else
	      answer_was_correct
      end
    end
    
    def wrong_answer
      puts 'Question was incorrectly answered'
      puts "#{@players[@current_player]} was sent to the penalty box"
      @in_penalty_box[@current_player] = true
      next_player
      true
    end
    
    private

    def answer_was_correct
	    puts "Answer was correct!!!!"
	    increase_score
	    puts "#{@players[@current_player]} now has #{@purses[@current_player]} Gold Coins."
	    winner = did_player_win()
	    next_player
	    winner
    end

    def increase_score
      @purses[@current_player] += 1
    end

    def move_player(roll)
      @board.move(@current_player, roll)
    end
    
    def next_player
      @current_player += 1
      @current_player = 0 if @current_player == @players.length
    end
    
    def ask_question
      puts @pop_questions.shift if current_category == 'Pop'
      puts @science_questions.shift if current_category == 'Science'
      puts @sports_questions.shift if current_category == 'Sports'
      puts @rock_questions.shift if current_category == 'Rock'
    end
    
    def current_category
      return 'Pop' if [0, 4, 8].member? current_place
      return 'Science' if [1, 5, 9].member? current_place
      return 'Sports' if [2, 6, 10].member? current_place
      return 'Rock'
    end
    
    def current_place
      @board.place(@current_player)
    end
    
    def did_player_win
      @purses[@current_player] != 6
    end
    
    def create_questions
      @pop_questions = []
      @science_questions = []
      @sports_questions = []
      @rock_questions = []
      
      50.times do |i|
	      @pop_questions.push "Pop Question #{i}"
	      @science_questions.push "Science Question #{i}"
	      @sports_questions.push "Sports Question #{i}"
	      @rock_questions.push "Rock Question #{i}"
      end
    end # create_questions

  end
end