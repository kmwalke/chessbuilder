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
end
