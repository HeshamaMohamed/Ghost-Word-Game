require 'rspec'
require 'game'

describe Game do
    let(:player1) { double("player1", :name => "p1")}
    let(:player2) { double("player2", :name => "p2")}
    subject(:game) {Game.new(player1, player2)}

    
    describe "#initialize" do
        let(:testGame) {Game.new(player1, player2)}

        it "has a dictionary" do
            expect(testGame.dictionary).to_not be nil
        end

        it "has 2 players" do
            expect(testGame.players.count).to eq(2)
        end

        it "has an empty word fragment" do
            expect(testGame.fragment).to eq("")
        end
        
    end


    describe "#play" do

        describe "#play_round" do

            describe "#not_dead_end?" do
                
                it "returns true if the new fragment is a starting of an existing word" do
                    words = game.dictionary
                    game.fragment = "sug"
                    expect(game.not_dead_end?("a")).to be true
                end
                it "returns false if the new fragment is a starting of an non-existing word" do
                    words = game.dictionary
                    game.fragment = "sug"
                    expect(game.not_dead_end?("x")).to be false
                end
            end

            describe "#is_a_letter?" do
                it "returns true if it is a letter" do
                    expect(game.is_a_letter?('a')).to be true
                    expect(game.is_a_letter?('d')).to be true
                end

                it "returns false if it is not a letter" do
                    expect(game.is_a_letter?('1')).to be false
                    expect(game.is_a_letter?('!')).to be false
                end
            end

            describe "#valid_play?" do
                it "Checks that string is a letter of the alphabet" do
                    expect(game.valid_play?('a')).to be true
                    expect(game.valid_play?('d')).to be true

                    expect(game.valid_play?(100)).to be false
                    expect(game.valid_play?('!')).to be false
                end

                it "Checks if there are words we can spell after adding it to the fragment" do
                    game.fragment = "sug"
                    expect(game.valid_play?('a')).to be true
                    game.fragment = "sug"
                    expect(game.valid_play?('x')).to be false
                end
            end

            describe "#current_player" do
                it "returns the current player" do
                    expect(game.current_player.name).to eq("p1")
                end
            end

            describe "#previous_player" do
                it "returns the previous player" do
                    expect(game.previous_player).to be nil
                    game.next_player!
                    expect(game.previous_player.name).to eq("p1")
                    game.next_player!
                    expect(game.previous_player.name).to eq("p2")
                end

            end

            describe "#next_player!" do
                it "updates the current_player and the previous_player" do
                    expect(game.current_player.name).to eq(player1.name)
                    expect(game.previous_player).to be nil

                    game.next_player!

                    expect(game.current_player.name).to eq(player2.name)
                    expect(game.previous_player.name).to eq(player1.name)

                end

            end
            
            describe "#update_fragment" do
                it "adds a letter to the fragment" do
                    game.update_fragment('a')
                    expect(game.fragment).to eq('a')
                    game.update_fragment('b')
                    expect(game.fragment).to eq('ab')
                    game.update_fragment('c')
                    expect(game.fragment).to eq('abc')
                end

            end

            describe "#show_letter_and_fragment" do
                it "shows entered letter and current fragment" do
                    game.fragment = "do"
                    expect(game.show_letter_and_fragment). to include("letter entered: o")
                end
            end

            describe "#take_turn" do

                it "takes a letter, updates the fragment, then rotate the players." do
                    expect(game.fragment).to eq("")
                    expect(game.current_player.name).to eq(game.players[0].name)
                    
                    game.take_turn(game.current_player, "a")
                    
                    expect(game.fragment).to eq("a")
                    expect(game.current_player.name).to eq(game.players[1].name)
                    
                    game.take_turn(game.current_player, "p")
                    
                    expect(game.fragment).to eq("ap")
                    expect(game.current_player.name).to eq(game.players[0].name)
                end
                
            end
            
            describe "#is_word?" do
                it "checks if the current fragment is a word" do
                    expect(game.is_word?("dog")).to be true
                    expect(game.is_word?("dogggooo")).to be false
                end
            end
            
            describe "#round_over?" do
                it "checks if the round is over" do
                    game.fragment = "dog"
                    expect(game.round_over?).to be true
                    game.fragment = "not_a_word"
                    expect(game.round_over?).to be false
                end
            end

            describe "#game_over?" do
                it "is false at game beginning" do
                    expect(game.game_over?).to be false
                end

                it "is true when only 1 player is left" do
                    game.remove_loser until game.playersRotated.count < 2
                    expect(game.game_over?).to be true
                end
            end
            
            describe "#update_standings" do
                
            end

            describe "#update_standings" do
                
            end
        end
    end




end