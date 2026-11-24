class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy, :move]

  def index
    game_action do
      @games = if current_user && !params[:all]
                 Game.where(host: current_user).or(Game.where(guest: current_user))
                     .strict_loading.eager_load(:host, :guest, :winner)
               else
                 Game.strict_loading.eager_load(:host, :guest, :winner)
               end
      @games = @games.order(:winner_id).reverse
    end
  end

  # TODO: refactor for readability/performance
  #    @game.update is called multiple times.  Should only make 1 db call at the end
  def move
    game_action(redirect: true, path: game_path(@game)) do
      @game.update(check: false) if @game.check
      move_piece(move_params[:from], move_params[:to])
      @game.take_turn unless @game.winner
      SendWebPushJob.perform_later(@game.current_player, "Your turn in #{@game.name}")
    end
  end

  def show; end

  def new
    game_action do
      @game = Game.new
    end
  end

  def edit; end

  def create
    game_action do
      @game = Game.new(game_params)

      respond_to do |format|
        if @game.save
          SendWebPushJob.perform_later(@game.guest, "#{@game.host.name} invited you to a game")
          format.html { redirect_to @game, notice: 'Game was successfully created.' }
        else
          format.html { render :new, status: :unprocessable_content }
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.', status: :see_other }
      else
        format.html { render :edit, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @game.destroy!

    respond_to do |format|
      format.html { redirect_to games_path, notice: 'Game was successfully destroyed.', status: :see_other }
    end
  end

  private

  def move_piece(from, to)
    piece = @game.pieces.find_by(position: from)
    raise ErrorMessages::CHEATING[:illegal_move] if illegal_move?(piece)

    capture(@game.pieces.find_by(position: to))
    piece.update(position: to, has_moved?: true)
    @game.update(check: true) if @game.valid_moves(piece).include?(other_king.position)
    MoveLog.create(game: @game, user: @game.current_player, a1_notation: "#{from}#{to}")
  end

  def illegal_move?(piece)
    not_your_turn?(piece) || invalid_move?(piece)
  end

  def not_your_turn?(piece)
    piece.player != @game.current_player_title
  end

  def invalid_move?(piece)
    @game.valid_moves(piece).exclude?(move_params[:to])
  end

  def capture(piece)
    return unless piece

    if piece.name == PieceCard::PAWN
      @game.current_player.update(upgrade_points: @game.current_player.upgrade_points + 1)
    end
    @game.update(winner: @game.current_player) if piece.name == PieceCard::KING
    piece.destroy
  end

  def other_king
    @game.pieces.detect do |p|
      [PieceCard::KING, PieceCard::EMPEROR].include?(p.name) && p.player != @game.current_player_title
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.strict_loading.eager_load(
      :host, :guest, :current_player, :winner, { pieces: :piece_card }, { move_logs: :user }
    ).find_by(id: params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def game_params
    params.expect(game: [:host_id, :guest_id, :current_player_id])
  end

  def move_params
    return @move_params if @move_params

    temp_params = params.expect(move: [:data, :to])
    raise ErrorMessages::BAD_INPUT[:select_piece] if temp_params['data'] == 'on'

    @move_params = temp_params.merge JSON.parse(temp_params[:data]).symbolize_keys
    unless @move_params[:to]
      @move_params = nil
      raise ErrorMessages::BAD_INPUT[:select_move]
    end

    @move_params
  end
end
