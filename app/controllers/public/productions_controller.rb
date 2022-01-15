class Public::ProductionsController < ApplicationController

  def new
    @production = Production.new
  end

  def create
    @production = Production.new(production_params)
    @production.customer_id = current_customer.id
    @production.save
    redirect_to production_path(@production.id), notice: '投稿が完了しました'
  end

  def index
    @production = Production.all
  end

  def show
    @production = Production.find(params[:id])
  end

  def edit
    @production = Production.find(params[:id])
  end

  def update
    @production = Production.find(params[:id])
    @production.images.purge
    @production.update(production_params)
    redirect_to production_path(@production.id)
  end

  def destroy
    @production = Production.find(params[:id])
    @production.destroy
    redirect_to productions_path
  end

  private
  def production_params
    params.require(:production).permit(:title, :introduction, images:[])
  end

end
