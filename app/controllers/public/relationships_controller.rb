class Public::RelationshipsController < ApplicationController
  before_action :set_production
  before_action :authenticate_customer!

  def create
    current_customer.follow(params[:customer_id])
  end

  def destroy
    current_customer.unfollow(params[:customer_id])
  end

  def followings
    customer = Customer.find(params[:customer_id])
    @customers = customer.followings
  end

  def followers
    customer = Customer.find(params[:customer_id])
    @customers = customer.followings
  end

  private
  def set_production
    @customer = Customer.find(params[:customer_id])
  end

end
