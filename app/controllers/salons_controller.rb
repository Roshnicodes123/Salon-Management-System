class SalonsController < ApplicationController

  def index
    @salons = Salon.paginate(page: params[:page], per_page: 2)
  end

  def show
    @salon = Salon.find(params[:id])
  end
end
