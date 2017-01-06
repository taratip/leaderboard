require 'spec_helper'

RSpec.describe Leaderboard do
  describe '.new' do
    leaderboard = Leaderboard.new()

    it 'should not take any arguments' do
      expect(leaderboard).to be_a(Leaderboard)
    end

    it 'should has a reader for teams' do
      expect(leaderboard.teams).to eq([])
    end
  end

  let(:team) { Team.new("Patriots") }
  let(:leaderboard) { Leaderboard.new() }

  describe '#add_team' do
    it 'should has one team in the list' do
      leaderboard.add_team("Patriots")
      expect(leaderboard.teams.count).to eq(1)
    end
  end

  describe '#get_all_teams' do
    it 'should have all teams from gameinfo' do
      leaderboard.get_all_teams
      expect(leaderboard.teams.count).to eq(4)
    end
  end

  describe '#has_team?' do
    it 'return true if already has the team in the list' do
      leaderboard.add_team("Patriots")
      expect(leaderboard.has_team?("Patriots")).to eq true
    end

    it 'return false if the team is not in the list' do
      leaderboard.add_team("Patriots")
      expect(leaderboard.has_team?("Cowboy")).to eq false
    end
  end

  describe '#current_win_score' do
    it 'should return 0 wins for the team' do
      leaderboard.add_team("Patriots")
      expect(leaderboard.current_win_score("Patriots")).to eq(0)
    end
  end

  describe '#current_loss_score' do
    it 'should return 0 losses for the team' do
      leaderboard.add_team("Patriots")
      expect(leaderboard.current_loss_score("Patriots")).to eq(0)
    end
  end

  describe '#update_win_count' do
    it 'Patriots should has 1 win' do
      leaderboard.add_team("Patriots")
      leaderboard.update_win_count("Patriots")
      expect(leaderboard.current_win_score("Patriots")).to eq(1)
    end
  end

  describe '#update_loss_count' do
    it 'Patriots should has 1 loss' do
      leaderboard.add_team("Patriots")
      leaderboard.update_loss_count("Patriots")
      expect(leaderboard.current_loss_score("Patriots")).to eq(1)
    end
  end

  describe '#get_scores' do
    it 'Patriots should 3 wins and 0 loses' do
      leaderboard.get_all_teams
      leaderboard.get_scores
      expect(leaderboard.current_win_score("Steelers")).to eq(1)
      expect(leaderboard.current_loss_score("Steelers")).to eq(1)
    end
  end

  describe '#team_rank' do
    it 'Patriots should rank # 1' do
      leaderboard.get_all_teams
      leaderboard.get_scores
      leaderboard.rank
      expect(leaderboard.team_rank("Steelers")).to eq(2)
    end
  end

  describe '#summary' do
    it 'Shoud print summary' do
      leaderboard.get_all_teams
      leaderboard.get_scores
      leaderboard.rank
      str = "-------------------------------------------\n"
      str += "| Name\tRank\tTotal Wins\tTotal Losses\t|\n"
      str += "| Patriots\t1\t3\t0\t|\n"
      str += "| Steelers\t2\t1\t1\t|\n"
      str += "| Broncos\t3\t1\t2\t|\n"
      str += "| Colts\t4\t0\t2\t|\n"
      str += "-------------------------------------------\n"
      expect(leaderboard.summary).to eq(str)
    end
  end

  describe '#team_game_summary' do
    it 'print the team game summary' do
      str = "Patriots played 3 games.\n"
      str += "They played as the home team against the Broncos and won: 17 to 13.\n"
      str += "They played as the home team against the Colts and won: 21 to 17.\n"
      str += "They played as the away team against the Steelers and won: 31 to 24.\n"
      expect(leaderboard.team_game_summary(team)).to eq(str)
    end
  end
end
