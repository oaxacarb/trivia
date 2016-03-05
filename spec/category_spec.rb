require 'spec_helper'
require 'category'

describe Category do
    describe "#current" do
        it "devuelve Pop para posición 0, 4, 8" do
            [0,4,8].each do|i| 
                expect(Category.new.current(i)).to eq("Pop")
            end
        end
        
        it "devuelve Science para posición 1,5,9" do
            [1,5,9].each do|i|
                expect(Category.new.current(i)).to eq("Science")
            end
        end

        it "devuelve Sports para posición 2,6,10" do
            [2,6,10].each do |i|
                expect(Category.new.current(i)).to eq("Sports")
            end 
        end
        
        it "devuelve Rock para posición 3" do
            expect(Category.new.current(3)).to eq("Rock")
        end
    end
end