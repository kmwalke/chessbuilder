module GamesHelper
  def movable?(game, piece)
    !game.winner &&
      belongs_to_current_user?(game, piece) &&
      current_users_turn?(game) &&
      game.valid_moves(piece).any?
  end

  def current_users_turn?(game)
    game.current_player == current_user
  end

  def belongs_to_current_user?(game, piece)
    game.send(piece.player.downcase) == current_user
  end
end
