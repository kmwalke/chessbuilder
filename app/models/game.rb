class Game < ApplicationRecord
  belongs_to :host, class_name: 'User'
  belongs_to :guest, class_name: 'User'
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

  private

  def setup_board
    build_board
    place_pieces
  end

  def build_board
    update(squares: {})
  end

  def place_pieces
    host.deck.piece_cards.each do |card|
      card.rules['start']&.each do |start_position|
        next if squares[start_position]

        piece                   = Piece.create(piece_card: card)
        squares[start_position] = piece.id
        break
      end
    end

    save
  end
end
