require 'spec_helper'
require 'places'

describe "Places" do
  describe "#place" do
    let(:places) { Places.new([0,6,8,3]) }
    
    it "devuelve el lugar actual de jugador 3" do
      player = 3
      expect(places.place(player)).to eq 3
    end
    
    it "devuelve el lugar actual de jugador 2" do
      player = 2
      expect(places.place(player)).to eq 8
    end

    it "devuelve el lugar actual de jugador 1" do
      player = 1
      expect(places.place(player)).to eq 6
    end
    
  end
  
    describe "#places" do
      it "devuelve el arreglo places [0,6,8]" do
        places = Places.new([0, 6, 8])
        expect(places.places).to eq [0, 6, 8]
      end
      
       it "devuelve el arreglo places [1,2,3]" do
        places = Places.new([1,2,3])
        expect(places.places).to eq [1,2,3]   
       end
    end
end
