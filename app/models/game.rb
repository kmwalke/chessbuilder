class Game < ApplicationRecord
  GUEST = 'Guest'.freeze
  HOST  = 'Host'.freeze

  belongs_to :host, class_name: 'User'
  belongs_to :guest, class_name: 'User'
  belongs_to :current_player, class_name: 'User'

  has_many :pieces, dependent: :destroy

  after_create :setup_board

  def board_width
    8
  end

  def board_height
    8
  end

  def name
    "#{host.name} VS #{guest.name} - #{created_at.to_fs(:long_ordinal)}"
  end

  # TODO: expand testing of this.  Its going to get complicated
  # TODO: watch for readability/complication/maintainability/performance
  def valid_moves(piece)
    moves = []

    # wow, this is complicated
    # if the moves are vectors, then multiply by distance.
    # But you almost have to loop and multiply by each value of distance
    # Maybe better to just loop through each space on the board and check if it is covered by move(vector)*distance?
    # that seems arduous
    piece.rules['moves'].each do |move|
      move_positions = calc_move_positions(piece, move)
      next if space_occupied?(piece, move_positions[0])

      moves = moves.union(move_positions)
    end
    moves
  end

  def take_turn
    update(current_player_id: [host_id, guest_id].difference([current_player_id])[0])
  end

  private

  def space_occupied?(piece, move_position)
    pieces.find { |new_piece| new_piece.position == move_position && new_piece.player == piece.player }
  end

  def calc_move_positions(piece, move)
    # TODO: Include distance here
    # return array of all movements in this direction
    # prob filter out friendly occupied spaces here instead of later
    position = xy_notation(piece.position)
    new_x    = position[:x] + move['x']
    new_y    = position[:y].send(direction(piece.player), move['y'])
    return [] if new_x > board_width || new_y > board_height

    [algebraic_notation(new_x, new_y)]
  end

  def direction(player)
    return :- if player == Game::GUEST

    :+
  end

  def setup_board
    place_host_pieces
    place_guest_pieces
  end

  def place_host_pieces
    host.deck.piece_cards.each do |card|
      card.rules['start'].each do |start_position|
        next if pieces.where(position: start_position).any?

        Piece.create(piece_card: card, player: Game::HOST, game: self, position: start_position)
        break
      end
    end
  end

  def place_guest_pieces
    guest.deck.piece_cards.each do |card|
      card.rules['start'].each do |start_position|
        start_position = convert_to_guest(start_position)
        next if pieces.where(position: start_position).any?

        Piece.create(piece_card: card, player: Game::GUEST, game: self, position: start_position)
        break
      end
    end

    save
  end

  def convert_to_guest(position)
    "#{position[0]}#{(board_height + 1) - position[1].to_i}"
  end
end
