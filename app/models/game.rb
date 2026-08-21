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

  def valid_moves(piece)
    moves = []

    piece.rules['moves'].each do |move|
      move_position = calc_move_position(piece, move)
      next if space_occupied?(piece, move_position)

      moves << move_position
    end
    moves
  end

  private

  def space_occupied?(piece, move_position)
    pieces.find { |new_piece| new_piece.position == move_position && new_piece.player == piece.player }
  end

  def calc_move_position(piece, move)
    position = xy_notation(piece.position)
    algebraic_notation(position[:x] + move['x'], position[:y].send(operator(piece.player), move['y']))
  end

  def operator(player)
    return '-' if player == Game::GUEST

    '+'
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
