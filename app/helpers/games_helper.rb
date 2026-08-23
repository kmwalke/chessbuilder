module GamesHelper
  def movable?(piece)
    belongs_to_current_user?(piece) && current_users_turn?
  end

  private

  def current_users_turn?
    @game.current_player == current_user
  end

  def belongs_to_current_user?(piece)
    @game.send(piece.player.downcase) == current_user
  end
end
