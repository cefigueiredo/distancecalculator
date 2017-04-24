require 'csv'

class RentalsController < ApplicationController
  before_action :set_rental, only: [:show, :edit, :update, :destroy]

  # GET /rentals
  # GET /rentals.json
  def index
    @rentals = Rental.all
  end

  # GET /rentals/1
  # GET /rentals/1.json
  def show
  end

  # GET /rentals/new
  def new
    @rental = Rental.new
  end

  # GET /rentals/1/edit
  def edit
  end

  # POST /rentals
  # POST /rentals.json
  def create
    @rental = Rental.new(rental_params)

    respond_to do |format|
      if @rental.save
        format.html { redirect_to @rental, notice: 'Rental was successfully created.' }
        format.json { render :show, status: :created, location: @rental }
      else
        format.html { render :new }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rentals/1
  # PATCH/PUT /rentals/1.json
  def update
    respond_to do |format|
      if @rental.update(rental_params)
        format.html { redirect_to @rental, notice: 'Rental was successfully updated.' }
        format.json { render :show, status: :ok, location: @rental }
      else
        format.html { render :edit }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rentals/1
  # DELETE /rentals/1.json
  def destroy
    @rental.destroy
    respond_to do |format|
      format.html { redirect_to rentals_url, notice: 'Rental was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rental
      @rental = Rental.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rental_params
      parameters = params.fetch(:rental, {}).permit(:name).to_h

      if params.fetch(:rental, {})[:positions_file].present?
        parameters.merge!(positions: parsed_positions(params[:rental][:positions_file]))
      end

      parameters
    end

    def parsed_positions(positions_file)
      csv = CSV.read positions_file.path, col_sep: ';'
      return nil if csv.empty?

      first = csv.first
      last = csv.last
      parsed_params = {
        start_position: {time: first[0], coordinates: "#{first[1]},#{first[2]}" },
        end_position: {time: last[0], coordinates: "#{last[1]},#{last[2]}" },
        transit_positions: []
      }

      csv[1..-2].each do |row|
        parsed_params[:transit_positions] << { time: row[0], coordinates: "#{row[1]},#{row[2]}" }
      end

      parsed_params
    rescue StandardError => e
      return nil
    end
end
