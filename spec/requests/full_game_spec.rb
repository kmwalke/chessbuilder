require 'rails_helper'

include ApplicationHelper

LOG = ActiveSupport::Logger.new($stdout)

MOVES = %w[
  e2e4 e7e5 g1f3 f7f6 f3e5 f6e5 d1h5 e8e7 h5e5 e7f7 f1c4 d7d5 c4d5 f7g6 h2h4 h7h5
  d5b7 c8b7 e5f5 g6h6 d2d4 g7g5 f5f7 d8e7 h4g5 e7g5 h1h5
].freeze

VERBOSE = false

def move_piece(game, move)
  LOG.debug move if VERBOSE
  from_position = move[0..1]
  to_position   = move[(move.length - 2)..]
  piece         = game.pieces.where(position: from_position).first

  raise "No piece at #{from_position}" unless piece

  post move_game_path(game), params: {
    move: {
      data: "{ \"piece_id\": #{piece.id}, \"from\": \"#{from_position}\" }",
      to: to_position
    }
  }
end

def display(game)
  (1..game.board_height).each do |y|
    y    = game.board_height + 1 - y
    line = y.to_s
    (1..game.board_width).each do |x|
      piece = game.pieces.where(position: algebraic_notation(x, y)).first
      line += piece&.symbol || '-'
    end
    LOG.debug line
  end
  LOG.debug ' abcdefgh'
  LOG.debug ''
end

RSpec.describe 'Full Game' do
  let!(:guest) { create(:user) }
  let!(:host) { create(:user) }
  let!(:game) { create(:game, host:, guest:) }

  #TODO: this should break currently.  non-valid moves should be blocked at the request level
  it 'play the game' do
    expect do
      display(game) if VERBOSE
      MOVES.each do |move|
        game.reload
        move_piece(game, move)
        display(game) if VERBOSE
      end
    end.not_to raise_error
  end
end
