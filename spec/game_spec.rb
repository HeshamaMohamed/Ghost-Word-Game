require 'rspec'
require 'game'

describe Game do
    let(:player1) { double("player1", :name => "p1")}
    let(:player2) { double("player2", :name => "p2")}
    subject(:game) {Game.new(player1, player2)}

    
    describe "#initialize" do
        let(:testGame) {Game.new(player1, player2)}

        it "has an dictionary" do
            expect(testGame.dictionary).to_not be nil
        end

        it "has 2 players" do
            expect(testGame.players.count).to eq(2)
        end

        it "has an empty word fragment" do
            expect(testGame.fragment).to eq("")
        end
        
    end


    describe "#play_round" do
        
        describe "#current_player" do
            it "returns the current player"

        end

        describe "#previous_player" do
            it "returns the previous player"

        end

        describe "#next_player!" do
            it "updates the current_player and the previous_player"

        end

        describe "#valid_play?" do
            it "Checks that string is a letter of the alphabet"

            it "Checks if there are words we can spell after adding it to the fragment"

        end

        describe "#add_letter_to_fragment" do
            it "adds a letter to the fragment"

        end

        describe "#take_turn" do
            it "takes a string from the player untill a valid play is made"

            it "updates the fragment and check against dictionary"

            it "alerts player if they make an invalid move."
            
        end




    end

    
    
    describe "#add_letter" do

        it "can add a letter to the fragment"

        it "add letter only if the play is valid."



    end

end