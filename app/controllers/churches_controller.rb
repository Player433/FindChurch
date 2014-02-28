class ChurchesController < ApplicationController
  before_action :set_church, only: [:show, :edit, :update, :destroy]

  # GET /churches/1
  # GET /churches/1.json
  def show
  end

  # GET /churches/new
  def new
    @church = Church.new
  end

  # GET /churches/1/edit
  def edit
    @denominations = Preferences.denominations
  end

  # POST /churches
  # POST /churches.json
  def create
    @church = Church.new(church_params)

    respond_to do |format|
      if @church.save
        format.html { redirect_to @church, notice: "#{@church.name} was successfully created." }
        format.json { render action: 'show', status: :created, location: @church }
      else
        format.html { render action: 'new' }
        format.json { render json: @church.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /churches/1
  # PATCH/PUT /churches/1.json
  def update
    puts "Church Parameters = #{params[:church]}"
    respond_to do |format|
      if @church.update(church_params)
        @church.details.update(church_params)
        format.html { redirect_to administration_churchManagement_path, notice: "#{@church.name} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @church.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /churches/1
  # DELETE /churches/1.json
  def destroy
    @church.destroy
    respond_to do |format|
      format.html { redirect_to administration_churchManagement_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_church
      @church = Church.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def church_params
      params[:church].permit(:name, :address, :state, :city, :zipCode, :denomination, :latitude, :longitude, :gmaps, details_attributes: [:description, :website] )
    end
end
