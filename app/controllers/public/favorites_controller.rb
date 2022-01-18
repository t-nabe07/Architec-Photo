class Public::FavoritesController < ApplicationController
  before_action :set_production
  before_action :authenticate_customer!   # ログイン中のユーザーのみに許可（未ログインなら、ログイン画面へ移動）

  def create
    if @production.customer_id != current_customer.id
      @favorite = Favorite.create(customer_id: current_customer.id, production_id: @production.id)
    end
  end

  def destroy
    @favorite = Favorite.find_by(customer_id: current_customer.id, production_id: @production.id)
    @favorite.destroy
  end

  private
  def set_production
    @production = Production.find(params[:production_id])
  end

end
