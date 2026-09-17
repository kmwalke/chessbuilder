class PieceCardsController < ApplicationController
  def index
    @piece_cards = PieceCard.strict_loading.order(:level, :name, :rank)
  end
end
