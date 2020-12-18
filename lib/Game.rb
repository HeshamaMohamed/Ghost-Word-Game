require_relative "Player"
require 'set'

class Game

    ALPHABET = Set.new("a".."z")
    MAX_LOSS_COUNT = 5
    attr_reader :players, :dictionary, :current_player, :previous_player, :playersRotated
    attr_accessor :fragment, :players, :dictionary
    def initialize(*players)
        words = File.readlines("dictionary.txt").map(&:chomp)
        @dictionary = Set.new(words)
        @players = players
        @playersRotated = @players.clone
        @fragment = ""
        @current_player = players.first
        @previous_player = nil
        @losses = Hash.new { |losses, player| losses[player] = 0}
    end

    def play
        play_round until game_over?
    end

    def game_over?
        @playersRotated.count == 1
    end

    def play_round
        take_turn(@current_player) until round_over?
        p "#{@previous_player.name} has lost the round"
        update_standings
    end
    
    def update_standings
        puts "#{previous_player} gets a letter!"
        if losses[previous_player] == MAX_LOSS_COUNT - 1
            puts "#{previous_player} has been eliminated!"
            remove_loser
        end
        losses[previous_player] += 1
        display_standings
    end

    def display_standings
        puts "Current standings:"
        playersRotated.each do |player|
        puts "#{player}: #{record(player)}"
        end
    end

    def remove_loser
        @playersRotated.pop
    end

    def round_over?
        is_word?(@fragment)
    end

    def is_word?(string)
        @dictionary.include?(string)        
    end

    def take_turn(player, letter = nil)
        letter = take_letter(player, letter = letter)
        update_fragment(letter)
        show_letter_and_fragment
        next_player!       
    end

    def show_letter_and_fragment
        p "letter entered: #{@fragment[@fragment.size-1]} and current fragment: #{@fragment}"
        
    end

    def update_fragment(letter)
        @fragment << letter
    end
    
    def next_player!
        player = @playersRotated.shift
        @playersRotated.push(player)
        @current_player = @playersRotated.first
        @previous_player = @playersRotated.last
    end

    def take_letter(player, letter = nil)
        p "Hello #{player.name}, please guess a letter"
        letter ||= gets.chomp
        while !valid_play?(letter)
            p "The letter you guessed is invalid, please enter another one."
        end
        letter
    end

    def valid_play?(letter)
        is_a_letter?(letter) && not_dead_end?(letter)
    end

    def is_a_letter?(string)
        ALPHABET.include?(string)
    end

    def not_dead_end?(string)
        new_fragment = @fragment + string
        @dictionary.any? { |word| word.start_with?(new_fragment) }
    end
    
end


# p1 = Player.new("p1")
# p2 = Player.new("p2")
# game = Game.new(p1,p2)
# game.play