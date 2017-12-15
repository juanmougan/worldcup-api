class IncidencesController < ApplicationController
  before_action :set_incidence, only: [:show, :update, :destroy]

  # GET /incidences
  def index
    @incidences = Incidence.all

    render json: @incidences
  end

  # GET /incidences/1
  def show
    render json: @incidence
  end

  # POST /incidences
  def create
    @incidence = Incidence.new(incidence_params)

    if @incidence.save
      render json: @incidence, status: :created, location: @incidence
    else
      render json: @incidence.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /incidences/1
  def update
    if @incidence.update(incidence_params)
      render json: @incidence
    else
      render json: @incidence.errors, status: :unprocessable_entity
    end
  end

  # DELETE /incidences/1
  def destroy
    @incidence.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incidence
      @incidence = Incidence.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def incidence_params
      params.require(:incidence).permit(:player_id, :match_id, :incidence_type, :status)
    end
end
