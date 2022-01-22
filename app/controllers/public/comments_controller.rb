class Public::CommentsController < ApplicationController
  before_action :set_production
  before_action :authenticate_customer!

  def create
    @production = Production.find(params[:production_id])
    @comment = Comment.new(comment_params)
    @comment.production_id = @production.id
    @comment.customer_id = current_customer.id
    @comment.save
  end

  def destroy
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
