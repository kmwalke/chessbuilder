module GamesHelper
  def piece_symbol(position)
    return unless @game.squares[position]

    Piece.find(@game.squares[position]).host_symbol
  end
end
