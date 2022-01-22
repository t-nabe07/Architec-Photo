class Admin::ProductionsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @productions = Production.all
  end

  def show
    @customer = Customer.find(params[:id])
    @productions = Production.all
  end

end
