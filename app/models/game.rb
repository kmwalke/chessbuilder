class Game < ApplicationRecord
  belongs_to :host, class_name: 'User'
  belongs_to :guest, class_name: 'User'

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

  def valid_moves(piece, pos_x, pos_y)
    moves = []

    piece.rules['moves'].each do |move|
      operator      = '+'
      operator      = '-' if piece.player == Piece::GUEST
      move_position = algebraic_notation(pos_x + move['x'], pos_y.send(operator, move['y']))
      next if pieces.find { |new_piece| new_piece.position == move_position && new_piece.player == piece.player }

      moves << move_position
    end
    moves
  end

  private

  def setup_board
    place_host_pieces
    place_guest_pieces
  end

  def place_host_pieces
    host.deck.piece_cards.each do |card|
      card.rules['start'].each do |start_position|
        next if pieces.where(position: start_position).any?

        Piece.create(piece_card: card, player: Piece::HOST, game: self, position: start_position)
        break
      end
    end
  end

  def place_guest_pieces
    guest.deck.piece_cards.each do |card|
      card.rules['start'].each do |start_position|
        start_position = convert_to_guest(start_position)
        next if pieces.where(position: start_position).any?

        Piece.create(piece_card: card, player: Piece::GUEST, game: self, position: start_position)
        break
      end
    end

    save
  end

  def convert_to_guest(position)
    "#{position[0]}#{(board_height + 1) - position[1].to_i}"
  end
end
