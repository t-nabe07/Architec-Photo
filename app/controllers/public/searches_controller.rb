class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!
  
  def search
    @range = params[:range]
    if @range == "ユーザー名"
      @customers = Customer.looks(params[:search], params[:word])
    else
      @productions = Production.looks(params[:search], params[:word])
    end
  end
  
end
