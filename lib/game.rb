class Game
  attr_reader :winner, :gameinfo

  def initialize(gameinfo)
    @gameinfo = gameinfo
    @winner = ""
  end

  def game_winner_message
    "#{@winner} won the game!"
  end

  def get_winner
    winner_score = 0
    @gameinfo.each do |team, score|
      if score > winner_score
        @winner = team.to_s.capitalize
        winner_score = score
      end
    end
  end
end
