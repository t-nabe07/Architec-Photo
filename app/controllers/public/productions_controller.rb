class Public::ProductionsController < ApplicationController

  def new
    @production = Production.new
  end

  def create
    production = Production.new(production_params)
    production.save
    redirect_to production_path(production.id)
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
    production = Production.find(params[:id])
    production.update(production_params)
    redirect_to production_path(production.id)
  end

  private
  def production_params
    params.require(:production).permit(:title, :introduction)
  end

end
