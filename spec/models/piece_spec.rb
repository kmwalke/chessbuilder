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

  describe 'delegates' do
    it 'name' do
      expect(host_piece.name).to eq(host_piece.piece_card.name)
    end

    it 'host_symbol' do
      expect(host_piece.host_symbol).to eq(host_piece.piece_card.host_symbol)
    end

    it 'guest_symbol' do
      expect(host_piece.guest_symbol).to eq(host_piece.piece_card.guest_symbol)
    end

    it 'rules' do
      expect(host_piece.rules).to eq(host_piece.piece_card.rules)
    end

    it 'start positions' do
      expect(host_piece.start_positions).to eq(host_piece.piece_card.start_positions)
    end

    it 'start vectors' do
      expect(host_piece.start_vectors).to eq(host_piece.piece_card.start_vectors)
    end

    it 'move vectors' do
      expect(host_piece.move_vectors).to eq(host_piece.piece_card.move_vectors)
    end

    it 'attack vectors' do
      expect(host_piece.attack_vectors).to eq(host_piece.piece_card.attack_vectors)
    end
  end
end
