require 'rails_helper'

RSpec.describe Piece do
  let(:guest_piece) { create(:piece, player: Game::GUEST, position: 'a0') }
  let(:host_piece) { create(:piece, player: Game::HOST, position: 'a0') }

  it 'shows host symbol' do
    expect(host_piece.symbol).to eq(host_piece.piece_card.host_symbol)
  end

  it 'shows guest symbol' do
    expect(guest_piece.symbol).to eq(guest_piece.piece_card.guest_symbol)
  end

  it 'shows string version' do
    expect(host_piece.to_s).to eq("#{host_piece.name} - #{host_piece.symbol}")
  end
end
