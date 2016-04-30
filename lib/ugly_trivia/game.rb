module UglyTrivia
  class Game
    def  initialize
      @players = []
      @board = Board.new(Array.new(6, 0))
      @purses = Array.new(6, 0)
      @penalty_box = PenaltyBox.new 
      
      @current_player = 0
      create_questions
    end
    
    def is_playable?
      how_many_players >= 2
    end

    def add(player_name)
      @players.push player_name
      @board.places[how_many_players] = 0
      @purses[how_many_players] = 0
      
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
      
      if @penalty_box.in_penalty_box?(@current_player)
	      if dice_roll.odd?
                @penalty_box.getting_out = true
	        
	        puts "#{@players[@current_player]} is getting out of the penalty box"
	        move_player(dice_roll)
	        puts "#{@players[@current_player]}'s new location is #{current_place}"
	        puts "The category is #{current_category}"
	        ask_question
	      else
	        puts "#{@players[@current_player]} is not getting out of the penalty box"
                @penalty_box.getting_out = false
	      end
      else
        move_player(dice_roll)
	      puts "#{@players[@current_player]}'s new location is #{current_place}"
	      puts "The category is #{current_category}"
	      ask_question
      end
    end
    
    def was_correctly_answered
      if @penalty_box.in_penalty_box?(@current_player)
        if @penalty_box.getting_out?
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
      @penalty_box.add @current_player
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
      puts @questions.ask(current_category)
    end
    
    def current_category
      category.current(current_place)
    end
    
    def category
      @category ||= Category.new
    end
       
    def current_place
      @board.place(@current_player)
    end
    
    def did_player_win
      @purses[@current_player] != 6
    end
    
    def create_questions
      @questions = Questions.new
    end # create_questions

  end
end
