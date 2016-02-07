class Questions
    def initialize
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
    end
    
    def ask(current_category)
    
      return @pop_questions.shift if current_category == 'Pop'
      return @science_questions.shift if current_category == 'Science'
      return @sports_questions.shift if current_category == 'Sports'
      return @rock_questions.shift if current_category == 'Rock'
    end
end