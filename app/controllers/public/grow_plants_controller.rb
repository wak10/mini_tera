class Public::GrowPlantsController < ApplicationController

  def index
    @plants = Plant.all
  end

  def pick
    @plant = Plant.find(params[:id])
    @grow_plant = GrowPlant.new
  end

  def create
    @grow_plant = current_user.grow_plants.new(grow_plant_params)
    @grow_plant.save
    redirect_to  top_path
  end

  def show
    @grow_plant = GrowPlant.find(params[:id])
    @log = Log.new
  end

  def complete
    @log = Log.new(log_params)
    @log.save
    redirect_to action: :show
  end

  def updete
  end

  def destroy
    @grow_plant = GrowPlant.find(params[:id])
    @grow_plant.destroy
    redirect_to top_path
  end

  private

  def plant_paramas
    params.require(:plant).permit( :plant_name, :image, :frequency, :amount, :advice)
  end

  def grow_plant_params
    params.require(:grow_plant).permit( :plant_id, :user_id, :nick_name)
  end

  def log_params
    params.require(:log).permit( :grow_plant_id, :user_id)
  end

end