class Game < ApplicationRecord
  GUEST  = 'Guest'.freeze
  HOST   = 'Host'.freeze
  ATTACK = :attack
  MOVE   = :move

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
  # TODO: CPU Intensive.  Each viewer puts CPU strain on server.  Add DB caching of valid_moves if this becomes a problem, so this is calculate once and fetch answer
  # This is run 64 times for each piece on the board!  Should at least be memory cached in the controller/view
  def valid_moves(piece)
    moves = []

    piece.rules['move_vectors'].each do |move_vector|
      moves = moves.union(calc_move_positions(piece, move_vector))
    end

    piece.rules['attack_vectors'].each do |attack_vector|
      moves = moves.union(calc_attack_positions(piece, attack_vector))
    end
    moves
  end

  def take_turn
    update(current_player_id: non_current_player_id)
  end

  private

  def non_current_player_id
    [host_id, guest_id].difference([current_player_id])[0]
  end

  # TODO: Refactor for readability, including submethods
  def calc_attack_positions(piece, attack_vector)
    calc_positions(piece, attack_vector, ATTACK)
  end

  def calc_move_positions(piece, move_vector)
    calc_positions(piece, move_vector, MOVE)
  end

  def calc_positions(piece, vector, mode)
    valid_moves  = []
    (1..vector['distance']).each do |distance|
      next if distance > board_height || distance > board_width

      new_x, new_y = calc_new_position(vector, distance, piece)
      break unless within_board?(new_x, new_y)

      new_position = algebraic_notation(new_x, new_y)
      break if space_occupied_by_friendly?(piece, new_position)
      break if space_occupied_by_enemy?(piece, new_position) && mode == MOVE
      break if !space_occupied_by_enemy?(piece, new_position) && mode == ATTACK

      valid_moves << new_position
      break if space_occupied_by_enemy?(piece, new_position)
    end
    valid_moves
  end

  def calc_new_position(vector, distance, piece)
    position = xy_notation(piece.position)

    [
      position[:x] + (vector['x'] * distance),
      position[:y].send(direction(piece.player), vector['y'] * distance)
    ]
  end

  def within_board?(pos_x, pos_y)
    pos_x.positive? && pos_y.positive? &&
      pos_x <= board_width && pos_y <= board_height
  end

  def space_occupied_by_friendly?(piece, move_position)
    pieces.find { |new_piece| new_piece.position == move_position && new_piece.player == piece.player }
  end

  def space_occupied_by_enemy?(piece, move_position)
    pieces.find { |new_piece| new_piece.position == move_position && new_piece.player != piece.player }
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
