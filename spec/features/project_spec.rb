require 'rails_helper'

RSpec.feature 'Project' do
  describe 'bugs' do
    it 'sometimes logs users out' do
      skip('find how to reproduce')
      # is it a timeout thing?
    end

    it 'movement overlay is misaligned' do
      skip('seems like a character width rendering issue')
    end
  end

  it 'refreshes game page' do
    skip('make page auto refresh for watchers and user whose turn it isn\'t')
    # DONE: V1: Simple JS auto refresh unless current_player == @game.current_player
    # V2: Some sort of push notification from server. clients must subscribe
    #     Use Turbo, only reload partial
  end

  it 'performance pass' do
    skip('later')
    # always watch for n+1 and unnecessary DB Calls
    # add `strict_loading` to everything that makes sense(maybe every single controller global var)

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
    #  But it would be more server calls.  better performance, maybe, at higher server costs
    #  If needed, do the math on that trade off
  end

  it 'address TODOs' do
    skip('search for all TODOs')
  end

  it 'gameplay outline' do
    skip('See Notes in project_spec')
  end

  it 'links' do
    skip('a place to store links for research. Maybe move to README?')
    # https://en.wikipedia.org/wiki/Chess_symbols_in_Unicode
    # https://en.wikipedia.org/wiki/Algebraic_notation_(chess)
    # https://www.reddit.com/r/chess/comments/he6tmj/here_are_30_alternative_chess_pieces_as/
  end

  # Piece card
  # - Just the pieces
  # - name, move
  # - could have cool new pieces:
  #                         https://www.reddit.com/r/chess/comments/he6tmj/here_are_30_alternative_chess_pieces_as/
  # - not exposed to the player.  The player just thinks of "pieces", not piece cards
  # - can be upgraded in crafting.  combine the same piece to upgrade
  #   = upgrading is like typical COMMON, RARE, Epic, etc...
  #   = what do upgraded pieces get?  More starting positions?
  #   = but named for military ranks
  #     + Front row(pawns) is enlisted ranks
  #     + Back row is officer ranks
  #   = upgrading increases possible starting positions
  #     + what other stuff does upgrading do?
  # - combine two different pieces to get a new piece
  #
  #
  #  Equipment Card
  # - Makes pieces stronger
  # - Attaches to a piece?  Equipment!
  # - Armor makes a piece take two hits to kill
  # - Boots make it move faster
  # - earn cards by capturing pieces with equipment equipped
  #   = Could "fake" this if needed: pick up COMMON equipment from unequipped pieces
  #   = combine equipment to level it up, COMMON, RARE, EPIC, etc..
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
  # Can earn new cards by capturing pieces in game.
  # You get the cards of pieces you capture, then craft with them between games
  # Can combine cards to upgrade?
  # - pawn + knight gives one thing
  # - pawn + bishop gives another
  # - armor + armor gives stronger armor?
  # - crafting element !?!?!

  # 9/11 play session
  # 'Hmm' button
  # highlight piece that just moved
  # Don't capture pieces, get resources from the pieces. craft with the resources
  # or captured pieces

  # on a win, pieces that didnt get captured upgrade.  So they can equip better/more equipment
  # Crafting pieces changes the piece behavior. Upgrading pieces changes their equipment capacity
  # "Equipment sets" set bonuses and a name change for all the set pieces
  # Maybe only combining with pawns can upgrade things
  #   like rook + 3 pawns = garrison
  #     rook + 1 upgraded pawn = garrison
  # So I want to capture lots of pawns, but since captured pawns get knocked to level 1, the other player wants to protect them
  # Maybe upgrade multiple time
  #    Garrison + 6 pawns = fortress
  # But you ALWAYS have 2 "rook-like" pieces (rook class with garrison specialization class)
  #   This solves the insane placement problem of how to place all the pieces when many have different starting positions
  # V1 is JUST pawns to craft.  later versions could be bishop + queen, etc...
  # So DONT allocate pieces to capturing player
  #   Instead, captured pawns becomes "upgrade points" or "captured pawns", but they are just an integer on a user account
  #     user.pawn_points
  #  Now we basically have an "upgrade store" where you spend pawn points to upgrade pieces

  # perhaps a level 2 bishop (archbisop) can move sideways once, switching colors and becoming a bishop for the rest of the game
  # focus on single use abilities that downgrade a level 2 piece to its level 1 version
  #  (level 1 is normal chess pieces)
  #  Maybe level 3 can do the move twice or do a bigger move once (xcom like AP, basically)
  #
  #
  # Live game with Keith:
  # Rook - Garrison (spawns pawn on death)
  # Knight - 3-1 L movement ONCE
  # Bishop - Archbishop (Switch colors once)
  # Queen - teleport via sacrifice once
  # King - It can move 2 Orthogonal ONCE (not diagonal)

  # The one time use abilities seems good
  # "You can use it to set up a strike or get out of a jam"
  # "the move is crazy, but we are left with a normal chess situation after"
  # The special move is something you keep in reserve for the right moment
  # These pieces feel pretty good for now
  # A garrison that makes it to the back row can spawn a pawn and upgrade it to queen!
end
