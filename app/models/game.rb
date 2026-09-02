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

    piece.rules['moves'].each do |move|
      moves = moves.union(calc_move_positions(piece, move))
    end
    moves
  end

  def take_turn
    update(current_player_id: [host_id, guest_id].difference([current_player_id])[0])
  end

  private

  def calc_move_positions(piece, move)
    # TODO: Include distance here
    # return array of all movements in this direction
    # prob filter out friendly occupied spaces here instead of later
    valid_moves  = []
    position     = xy_notation(piece.position)
    (0..move['distance']).each do |distance|
      next if distance > board_height || distance > board_width
      new_x = position[:x] + (move['x'] * distance)
      new_y = position[:y].send(direction(piece.player), move['y'] * distance)
      new_position = algebraic_notation(new_x, new_y)
      valid_moves << new_position if within_board?(new_x, new_y) && space_open?(piece, new_position)
    end
    valid_moves
  end

  def within_board?(pos_x, pos_y)
    pos_x <= board_width && pos_y <= board_height
  end

  def space_open?(piece, move_position)
    pieces.find { |new_piece| new_piece.position == move_position && new_piece.player == piece.player }.nil?
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
        start_position = convert_position_to_guest(start_position)
        next if pieces.where(position: start_position).any?

        Piece.create(piece_card: card, player: Game::GUEST, game: self, position: start_position)
        break
      end
    end

    save
  end

  def convert_position_to_guest(position)
    "#{position[0]}#{(board_height + 1) - position[1].to_i}"
  end
end
