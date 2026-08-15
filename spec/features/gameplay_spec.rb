require 'rails_helper'

RSpec.feature 'Gameplay' do
  it 'setup simplecov and catch testing up' do
    skip('once some basic mvp is achieved')
  end

  it 'performance pass' do
    skip('later')
    # perhaps save renders chessboard to db
    # @game.current_board or something
    # Server calculates once and serves it to each page view
    # Currently, it is recalculated for each page view

    # also need to make the rendering itself quicker
  end

  it 'address TODOs' do
    skip('search for all TODOs')
  end

  it 'does all the stuff below' do
    skip('See Notes in gameplay_spec')
  end

  # https://en.wikipedia.org/wiki/Chess_symbols_in_Unicode
  # https://en.wikipedia.org/wiki/Algebraic_notation_(chess)

  # Piece card
  # - Just the pieces
  # - name, move
  # - could have cool new pieces:
  #                         https://www.reddit.com/r/chess/comments/he6tmj/here_are_30_alternative_chess_pieces_as/
  #
  #   Equipment Card
  # - Makes pieces stronger
  # - Attaches to a piece?  Equipment!
  # - Armor makes a piece take two hits to kill
  # - Boots make it move faster
  #
  # Power/bonus card
  # - affect the rules of the game
  # - limited number of turns
  # - armor is boosted
  # - pacman torus movement mode
  # - etc...
  #
  #
  #   Start with a Deck that makes a normal deck
  # Can earn new cards
  # Can combine cards to upgrade?
  # - pawn + knight gives one thing
  # - pawn + bishop gives another
  # - armor + armor gives stronger armor?
  # - crafting element !?!?!
end
