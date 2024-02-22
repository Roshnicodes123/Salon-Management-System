class SalonsController < ApplicationController

  def index
    @q = Salon.ransack(params[:q])
    @salons = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
  end

  def show
    @salon = Salon.find(params[:id])
  end
end
