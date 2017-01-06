class Team
  attr_reader :name
  attr_accessor :rank, :wins, :losses, :net_win

  def initialize(name)
    @name = name
    @wins = 0
    @losses = 0
    @net_win = 0
  end
end
