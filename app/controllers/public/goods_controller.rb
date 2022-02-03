class Public::GoodsController < ApplicationController
  before_action :set_production
  before_action :authenticate_customer!

  def create
    @production = Production.find(params[:production_id])
    good = @production.goods.new(customer_id: current_customer.id)
    good.save
    #通知レコードを作成
    production.create_notification_good!(current_customer)
  end

  def destroy
    @production = Production.find(params[:production_id])
    good = @production.goods.find_by(customer_id: current_customer.id)
    good.destroy
  end

  private

  def set_production
    @production = Production.find(params[:production_id])
  end
end
