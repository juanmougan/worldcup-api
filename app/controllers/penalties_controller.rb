class PenaltiesController < ApplicationController
  before_action :set_penalty, only: [:show, :update, :destroy]

  # GET /penalties
  def index
    @penalties = Penalty.all

    render json: @penalties
  end

  # GET /penalties/1
  def show
    render json: @penalty
  end

  # POST /penalties
  def create
    @penalty = Penalty.new(penalty_params)

    if @penalty.save
      render json: @penalty, status: :created, location: @penalty
    else
      render json: @penalty.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /penalties/1
  def update
    if @penalty.update(penalty_params)
      render json: @penalty
    else
      render json: @penalty.errors, status: :unprocessable_entity
    end
  end

  # DELETE /penalties/1
  def destroy
    @penalty.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_penalty
      @penalty = Penalty.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def penalty_params
      params.require(:penalty).permit(:player_id, :match_id, :length, :status)
    end
end
