class InboundChurchesController < ApplicationController
  before_action :set_inbound_church, only: [:show, :edit, :update, :destroy]

  # GET /inbound_churches
  # GET /inbound_churches.json
  def index
    @inbound_churches = InboundChurch.all
  end

  # GET /inbound_churches/1
  # GET /inbound_churches/1.json
  def show
  end

  # GET /inbound_churches/new
  def new
    @inbound_church = InboundChurch.new
  end

  # GET /inbound_churches/1/edit
  def edit
    @denominations = Preferences.denominations
    @json = @inbound_church.to_gmaps4rails
    puts "@JSON = #{@json}"
  end

  # POST /inbound_churches
  # POST /inbound_churches.json
  def create
    @inbound_church = InboundChurch.new(inbound_church_params)

    respond_to do |format|
      if @inbound_church.save
        format.html { redirect_to administration_newChurches_path, notice: 'Inbound church was successfully created.' }
        format.json { render action: 'show', status: :created, location: @inbound_church }
      else
        format.html { render action: 'new' }
        format.json { render json: @inbound_church.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inbound_churches/1
  # PATCH/PUT /inbound_churches/1.json
  def update
    respond_to do |format|
      if @inbound_church.update(inbound_church_params)
        format.html { redirect_to administration_newChurches_path, notice: 'Inbound church was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @inbound_church.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inbound_churches/1
  # DELETE /inbound_churches/1.json
  def destroy
    flash[:notice] = "#{@inbound_church.name} church was successfully destroyed."
    @inbound_church.destroy
    respond_to do |format|
      format.html { redirect_to administration_newChurches_path }
      format.json { head :no_content }
    end
  end
  
  def destroySelected
    if(params[:newChurch_ids].blank?)
      flash[:notice] = "Churches Selected = #{params[:newChurch_ids].inspect}"
      puts "Churches Selected = #{params[:newChurch_ids].inspect}"
    else
      flash[:notice] = "Nothing Selected"
      puts "Nothing Selected"
    end
    
    redirect_to administration_newChurches_path
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inbound_church
      @inbound_church = InboundChurch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inbound_church_params
      params.require(:inbound_church).permit(:name, :description, :address, :state, :city, :zipCode, :denomination, :latitude, :longitude, :gmaps, :googleId, :website)
    end
end
