require_relative 'player'
require_relative 'question'

class Game
  def initialize
    @players = [Player.new("Player 1"), Player.new("Player 2")]
    @current_index = 0
  end

  def next_player
    @current_index = (@current_index + 1) % @players.length
    @players[@current_index]
  end

  def play
    while @players.all?(&:alive?)
      current_player = next_player
      question = Question.new
      puts "#{current_player.name}: #{question.query}"
      print "> "
      answer = gets.chomp.to_i
      if answer == question.answer
        puts "#{current_player.name}: YES! You are correct."
      else
        current_player.lose_life
        puts "#{current_player.name}: Seriously? No!"
      end
      display_scores
    end
    announce_winner
  end

  private

  def display_scores
    @players.each { |player| puts "#{player.name}: #{player.lives}/3 lives left" }
  end

  def announce_winner
    winner = @players.find(&:alive?)
    puts "#{winner.name} wins with a score of #{winner.lives}/3"
    puts "----- GAME OVER -----"
    puts "Good bye!"
  end
end 
