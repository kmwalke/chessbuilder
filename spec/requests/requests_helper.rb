require './app/helpers/application_helper'

LOG     = ActiveSupport::Logger.new($stdout)
VERBOSE = false

def move_piece(game, move)
  LOG.debug move if VERBOSE
  from_position = move[0..1]
  to_position   = move[(move.length - 2)..]
  piece         = game.pieces.where(position: from_position).first

  raise "No piece at #{from_position}" unless piece

  post move_game_path(game), params: {
    move: {
      data: "{ \"piece_id\": #{piece.id}, \"from\": \"#{from_position}\" }",
      to: to_position
    }
  }
end

def display(game)
  (1..game.board_height).each do |y|
    y    = game.board_height + 1 - y
    line = y.to_s
    (1..game.board_width).each do |x|
      piece = game.pieces.where(position: algebraic_notation(x, y)).first
      line += piece&.symbol || '-'
    end
    LOG.debug line
  end
  LOG.debug ' abcdefgh'
  LOG.debug ''
end
