class AddHasMovedToPieces < ActiveRecord::Migration[8.1]
  def up
    add_column :pieces, :has_moved?, :boolean, null: false, default: false

    # at this point, only pawns have a start_vector
    Piece.joins(:piece_card).where(piece_card: { name: PieceCard::PAWN }).find_each do |pawn|
      next unless pawn.rules['start'].include?(pawn.position)

      pawn.update(has_moved?: true)
    end
  end

  def down
    remove_column :pieces, :has_moved?
  end
end
