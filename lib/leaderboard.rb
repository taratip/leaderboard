class Leaderboard
GAME_INFO = [
    {
      home_team: "Patriots",
      away_team: "Broncos",
      home_score: 17,
      away_score: 13
    },
    {
      home_team: "Broncos",
      away_team: "Colts",
      home_score: 24,
      away_score: 7
    },
    {
      home_team: "Patriots",
      away_team: "Colts",
      home_score: 21,
      away_score: 17
    },
    {
      home_team: "Broncos",
      away_team: "Steelers",
      home_score: 11,
      away_score: 27
    },
    {
      home_team: "Steelers",
      away_team: "Patriots",
      home_score: 24,
      away_score: 31
    }
]

  attr_reader :gameinfo, :teams

  def initialize
    @gameinfo = GAME_INFO
    @teams = []
  end

  def get_all_teams
    @gameinfo.each do |game|
      if !has_team?(game[:home_team])
        add_team(game[:home_team])
      end

      if !has_team?(game[:away_team])
        add_team(game[:away_team])
      end
    end
  end

  def add_team(adding_team)
    @teams << Team.new(adding_team)
  end

  def has_team?(adding_team)
    already_has = false
    @teams.each do |team|
      if team.name == adding_team
        already_has = true
        break
      end
    end
    already_has
  end

  def current_win_score(team_name)
    wins = @teams.select { |team| team.name == team_name }
            .map { |team| team.wins }
    wins[0]
  end

  def current_loss_score(team_name)
    wins = @teams.select { |team| team.name == team_name }
            .map { |team| team.losses }
    wins[0].to_i
  end

  def get_scores
    @gameinfo.each do |game|
      if game[:home_score] > game[:away_score]
        update_win_count(game[:home_team])
        update_loss_count(game[:away_team])
      else
        update_loss_count(game[:home_team])
        update_win_count(game[:away_team])
      end
    end
  end

  def update_win_count(team_name)
    @teams.each do |team|
      if team.name == team_name
        team.wins += 1
      end
    end
  end

  def update_loss_count(team_name)
    @teams.each do |team|
      if team.name == team_name
        team.losses += 1
      end
    end
  end

  def rank
    @teams.each do |team|
      team.net_win = team.wins - team.losses
    end

    @teams.sort! do |x, y|
      y.net_win <=> x.net_win
    end

    @teams.each_with_index do |team, index|
      team.rank = index + 1
    end
  end

  def team_rank(team_name)
    wins = @teams.select { |team| team.name == team_name } .map { |team| team.rank }
    wins[0].to_i
  end

  def summary
    str = "-------------------------------------------\n"
    str += "| Name\tRank\tTotal Wins\tTotal Losses\t|\n"
    @teams.each do |team|
      str += "| #{team.name}\t#{team.rank}\t#{team.wins}\t#{team.losses}\t|\n"
    end
    str += "-------------------------------------------\n"
    str
  end

  def team_game_summary(team)
    str = "#{team.name} played #{total_game(team)} games.\n"
    GAME_INFO.each do |game|
      if game[:home_team] == team.name || game[:away_team] == team.name
        str += "They played as the "
        if game[:home_team] == team.name
          str += "home team against the #{game[:away_team]} and "
          if game[:home_score ] > game[:away_score]
            str += "won: #{game[:home_score]} to #{game[:away_score]}.\n"
          else
            str += "lost: #{game[:home_score]} to #{game[:away_score]}.\n"
          end
        else
          str += "away team against the #{game[:home_team]} and "
          if game[:away_score ] > game[:home_score]
            str += "won: #{game[:away_score]} to #{game[:home_score]}.\n"
          else
            str += "lost: #{game[:away_score]} to #{game[:home_score]}.\n"
          end
        end
      end
    end
    str
  end

  def total_game(team)
    count = 0
    GAME_INFO.each do |game|
      if game[:home_team] == team.name || game[:away_team] == team.name
        count += 1
      end
    end
    count
  end
end
