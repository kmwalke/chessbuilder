require 'rails_helper'

RSpec.feature 'Project' do
  it 'refreshes game page' do
    skip('make page auto refresh for watchers and user whose turn it isn\'t')
    # V1: Simple JS auto refresh unless current_player == @game.current_player
    # V2: Some sort of push notification from server. clients must subscribe
  end

  it 'performance pass' do
    skip('later')
    # perhaps save renders chessboard to db
    # @game.current_board or something
    # Server calculates once and serves it to each page view
    # Currently, it is recalculated for each page view

    # I think using json to store ID's is bad.  It prevents rails's auto caching features.
    # I could probably set up some auto caching, but rails would do it easily if I used rails relations
    # @game.peices.first.position = g3 ?
    # @game.pieces.where(position: 'a3') ?
    # Then @game.pieces can be cached
    # game.rb:25 is causing a million individual DB calls.  And other spots are bad, too

    # also need to make the rendering itself quicker
    # Instead of pre-rendering each piece's possible moves, maybe turbo with server calls
    # GET game/1/pieces/2/moves and render the results?
    #  More server calls vs 1 call with big response.
    #  This would make things more lightweight.  watchers would get smaller responses. Host wouldn't get guests' moves
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
