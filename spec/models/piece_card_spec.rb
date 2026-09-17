require 'rails_helper'

RSpec.describe PieceCard do
  let(:pawn_piece_card) { create(:piece_card, name: PieceCard::PAWN) }
  let(:rook_piece_card) { create(:piece_card, name: PieceCard::ROOK) }

  describe 'rank_name' do
    it 'gets enlisted name' do
      expect(pawn_piece_card.rank_name).to eq('Private')
    end

    it 'gets officer name' do
      expect(rook_piece_card.rank_name).to eq('Lieutenant')
    end
  end

  it 'gets start positions' do
    expect(pawn_piece_card.start_positions).to eq(pawn_piece_card.rules['start'])
  end

  it 'gets move vectors' do
    expect(pawn_piece_card.move_vectors).to eq(pawn_piece_card.rules['move_vectors'])
  end

  it 'gets attack vectors' do
    expect(pawn_piece_card.attack_vectors).to eq(pawn_piece_card.rules['attack_vectors'])
  end

  it 'gets start vectors' do
    expect(pawn_piece_card.start_vectors).to eq(pawn_piece_card.rules['start_vectors'])
  end
end
