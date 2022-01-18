class Public::CommentsController < ApplicationController
  before_action :set_production
  before_action :authenticate_customer!

  def create
    @production = Production.find(params[:production_id])
    @comment = Comment.new(comment_params)
    @comment.production_id = @production.id
    @comment.customer_id = current_customer.id
    @comment.save

    #production = Production.find(params[:production_id])
    #comment = current_customer.comments.new(comment_params)
    #comment.production_id = production.id
    #comment.save
    #redirect_to production_path(production)
  end

  def destroy
    #Comment.find_by(id: params[:id]).destroy
    #redirect_to production_path(params[:production_id])
    @production = Production.find(params[:production_id])
    comment = @production.comments.find(params[:id])
    comment.destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end

  def set_production
    @production = Production.find(params[:production_id])
  end


end
