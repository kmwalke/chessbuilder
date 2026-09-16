require 'rails_helper'
require './spec/requests/requests_helper'

MOVES   = %w[
  e2e4 e7e5 g1f3 f7f6 f3e5 f6e5 d1h5 e8e7 h5e5 e7f7 f1c4 d7d5 c4d5 f7g6 h2h4 h7h5
  d5b7 c8b7 e5f5 g6h6 d2d4 g7g5 f5f7 d8e7 h4g5 e7g5 h1h5
].freeze

RSpec.describe 'Full Game' do
  let!(:guest) { create(:user) }
  let!(:host) { create(:user) }
  let!(:game) { create(:game, host:, guest:) }

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
