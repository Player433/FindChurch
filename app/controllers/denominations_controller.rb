class DenominationsController < ApplicationController
  before_action :set_denomination, only: [:show, :edit, :update, :destroy]

  def create
    puts "CREATED DENOMINATION"
    @denomination = Denomination.new(denomination_params)
    respond_to do |format|
      if @denomination.save
        Denomination.expire_all_cache
        format.html { redirect_to administration_webOptions_path, notice: 'Denomination, "#{@denomination}" was successfully created.' }
      else
        format.html { render administration_webOptions_path, notice: "Denomination failed to create" }
      end
    end
  end

  # PATCH/PUT /denominations/1
  def update
    puts "UPDATED DENOMINATION"
    respond_to do |format|
      if @denomination.update(denomination_params)
        Denomination.expire_all_cache
        format.html { redirect_to administration_webOptions_path, notice: 'Denomination was successfully updated.' }
      else
        format.html { render administration_webOptions_path, notice: "Denomination failed to update" }
      end
    end
  end

  # DELETE /denominations/1
  def destroy
    puts "DELETED DENOMINATION"
    @denomination.destroy
    Denomination.expire_all_cache
    respond_to do |format|
      format.html { redirect_to administration_webOptions_path, notice: 'Denomination was successfully Destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_denomination
      @denomination = Denomination.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def denomination_params
      params.require(:denomination).permit(:name)
    end
end
