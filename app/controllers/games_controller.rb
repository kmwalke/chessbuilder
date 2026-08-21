class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy, :move]

  def index
    @games = Game.all
  end

  def move
    # TODO: protect from dissapearing pieces.  Return unless :to param is set. in fact, require all params
    captured_piece = @game.pieces.find_by(position: move_params[:to])
    captured_piece&.destroy
    piece          = @game.pieces.find_by(position: move_params[:from])
    piece.update(position: move_params[:to])
    redirect_to @game
  end

  def show; end

  def new
    @game = Game.new
  end

  def edit; end

  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_content }
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

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.strict_loading.eager_load(:host, :guest, pieces: :piece_card).find_by(id: params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def game_params
    params.expect(game: [:host_id, :guest_id, :current_player_id])
  end

  def move_params
    temp_params = params.expect(move: [:data, :to])
    temp_params.merge JSON.parse(temp_params[:data]).symbolize_keys
  end
end
