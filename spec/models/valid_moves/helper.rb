def setup_board(layout)
  [Game::HOST, Game::GUEST].each do |player|
    layout[player].each_pair do |position, piece_class|
      Piece.create(game:, piece_card: PieceCard.where(name: piece_class).first, player:, position:)
    end
  end
end

def moves_from(position)
  game.valid_moves(game.pieces.where(position:).first)
end
