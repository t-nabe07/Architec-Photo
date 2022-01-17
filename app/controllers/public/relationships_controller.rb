class Public::RelationshipsController < ApplicationController
  before_action :authenticate_customer!

  def create
    current_customer.follow(params[:customer_id])
    redirect_to request.referer
  end

  def destroy
    current_customer.unfollow(params[:customer_id])
    redirect_to request.referer
  end

  def followings
    customer = Customer.find(params[:customer_id])
    @customer = customer.followings
  end

  def fowwowers
    customer = Customer.find(params[:customer_id])
    @customer = customer.followers
  end

end
