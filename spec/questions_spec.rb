require 'spec_helper'
require 'questions'

describe "Questions" do
    describe "#ask" do
        it "regresa una pregunta de la categoría pop cuando la categoría solicitada es pop" do
            questions = Questions.new
            expect(questions.ask("Pop")).to eq "Pop Question 0"
        end
        
        it "regresa una pregunta de la categoría science cuando la categoría solicitada es science" do
            questions = Questions.new
            expect(questions.ask("Science")).to eq "Science Question 0"
        end
        
        it "regresa una pregunta de la categoría sport cuando la categoría solicitada es sport" do
            questions = Questions.new
            questions.ask("Sports")
            expect(questions.ask("Sports")).to eq "Sports Question 1"
        end
    end
end
