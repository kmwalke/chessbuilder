class PieceCardsController < ApplicationController
  def index
    @piece_cards = PieceCard.strict_loading.order(:rank, :level, :name)
  end
end
