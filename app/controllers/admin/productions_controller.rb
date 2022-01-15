class Admin::ProductionsController < ApplicationController

  def index
    @productions = Production.all
  end

  def show
    @customer = Customer.find(params[:id])
    @productions = Production.all
  end

end
