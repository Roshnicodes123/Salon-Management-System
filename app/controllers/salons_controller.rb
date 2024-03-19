class SalonsController < ApplicationController
  # before_action :authenticate_user!


  def index
    @q = Salon.ransack(params[:q])
    @salons = @q.result(distinct: true).paginate(page: params[:page], per_page: 2)
  end

  def show
    @q = Service.ransack(params[:q])
    @services = @q.result(distinct: true).paginate(page: params[:page], per_page: 2)


    @salon = Salon.find(params[:id])
  end
end
