module ApplicationHelper
  LETTERS = %w[z a b c d e f g h].freeze

  def algebraic_notation(pos_x, pos_y)
    "#{LETTERS[pos_x]}#{pos_y}"
  end
end
