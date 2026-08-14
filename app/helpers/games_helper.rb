module GamesHelper
  def piece(position)
    return unless @game.squares[position]

    Piece.find(@game.squares[position])
  end
end
