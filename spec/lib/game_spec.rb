require 'spec_helper'

RSpec.describe Game do
  describe '.new' do
    game = Game.new({ patriots: 12, steelers: 2})

    it 'it should have one arguments' do
      expect(game).to be_a(Game)
    end

    it 'it should have a reader winner' do
      expect(game.winner).to eq("")
    end
  end

  let(:game) { Game.new({ patriots: 12, steelers: 2}) }

  describe '#get_winner' do
    it 'it should get a winner' do
      game.get_winner
      expect(game.winner).to eq("Patriots")
    end
  end

  describe '#game_winner_message' do
    it 'talles the user who won a specific game' do
      game.get_winner
      expect(game.game_winner_message).to eq "Patriots won the game!"
    end
  end
end
