require 'rails_helper'

RSpec.describe Game do
  let(:game) { create(:game) }

  it 'displays a name' do
    expect(game.name).to eq("#{game.host.name} VS #{game.guest.name} - #{game.created_at.to_fs(:long_ordinal)}")
  end

  it 'takes turns' do
    player = game.current_player
    game.take_turn

    expect(game.current_player).not_to eq(player)
  end

  it 'doesn\'t take turn if game is over' do
    game.update(winner: game.host)

    expect { game.take_turn }.to raise_error(RuntimeError, ErrorMessages::GAME[:game_over])
  end

  describe 'valid moves' do
    it 'lists valid moves' do
      piece = game.pieces.find_by(piece_card: PieceCard.find_by(name: PieceCard::KING), player: Game::GUEST)
      piece.update(position: 'd4')

      expect(game.valid_moves(piece)).to eq(%w[c3 c4 c5 d3 d5 e3 e4 e5])
    end

    it 'doesn\'t list your own pieces as valid move' do
      piece = game.pieces.find_by(piece_card: PieceCard.find_by(name: PieceCard::KING), player: Game::GUEST)
      piece.update(position: 'd6')

      expect(game.valid_moves(piece)).to eq(%w[c5 c6 d5 e5 e6])
    end
  end

  describe 'name_and_status' do
    it 'unfinished game' do
      expect(game.name_and_status(game.host)).to eq(game.name)
    end

    it 'won game' do
      game.update(winner: game.host)
      expect(game.name_and_status(game.host)).to eq("Won - #{game.name}")
    end

    it 'lost game' do
      game.update(winner: game.guest)
      expect(game.name_and_status(game.host)).to eq("Lost - #{game.name}")
    end

    it 'not your finished game' do
      game.update(winner: game.host)
      expect(game.name_and_status(create(:user))).to eq(game.name)
    end
  end
end
