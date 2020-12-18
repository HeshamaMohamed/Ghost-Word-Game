require_relative "Player"
require 'set'

class Game

    ALPHABET = Set.new("a".."z")
    attr_reader :players, :dictionary
    attr_accessor :fragment, :players, :dictionary
    def initialize(*players)
        words = File.readlines("dictionary.txt").map(&:chomp)
        @players = players
        @playersRotated = @players.clone
        @fragment = ""
        @dictionary = Set.new(words)
        @current_player = players.first
        @previous_player = nil
    end

    def play
        play_round
    end

    def play_round
        while !round_over?
            take_turn(@current_player)
        end
        p "#{@previous_player.name} has lost the round"
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

    def current_player
        next_player! if @current_player == ""
        @current_player
    end

    def previous_player
        if @previous_player == ""
            @previous_player 
        else
            @previous_player
        end
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