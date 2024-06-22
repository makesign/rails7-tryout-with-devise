class GeheimsController < ApplicationController
  before_action :set_geheim, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /geheims or /geheims.json
  def index
    @geheims = Geheim.all
  end

  # GET /geheims/1 or /geheims/1.json
  def show
  end

  # GET /geheims/new
  def new
    @geheim = Geheim.new
  end

  # GET /geheims/1/edit
  def edit
  end

  # POST /geheims or /geheims.json
  def create
    @geheim = Geheim.new(geheim_params)

    respond_to do |format|
      if @geheim.save
        format.html { redirect_to geheim_url(@geheim), notice: "Geheim was successfully created." }
        format.json { render :show, status: :created, location: @geheim }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @geheim.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /geheims/1 or /geheims/1.json
  def update
    respond_to do |format|
      if @geheim.update(geheim_params)
        format.html { redirect_to geheim_url(@geheim), notice: "Geheim was successfully updated." }
        format.json { render :show, status: :ok, location: @geheim }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @geheim.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /geheims/1 or /geheims/1.json
  def destroy
    @geheim.destroy!

    respond_to do |format|
      format.html { redirect_to geheims_url, notice: "Geheim was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_geheim
      @geheim = Geheim.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def geheim_params
      params.require(:geheim).permit(:title, :content)
    end
end
