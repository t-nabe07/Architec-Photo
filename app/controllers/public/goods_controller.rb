class Public::GoodsController < ApplicationController

  def create
    production = Production.find(params[:production_id])
    good = current_customer.goods.new(production_id: production.id)
    good.save
    redirect_to production_path(production)
  end

  def destroy
    production = Production.find(params[:production_id])
    good = current_customer.goods.find_by(production_id: production.id)
    good.destroy
    redirect_to production_path(production)
  end

end
