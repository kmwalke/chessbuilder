class PieceCardsController < ApplicationController
  def index
    @piece_cards = PieceCard.strict_loading.order(:level, :rank, :name)
  end
end
