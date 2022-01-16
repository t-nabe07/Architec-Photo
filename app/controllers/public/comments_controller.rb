class Public::CommentsController < ApplicationController

  def create
    production = Production.find(params[:production_id])
    comment = current_customer.comments.new(comment_params)
    comment.production_id = production.id
    comment.save
    redirect_to production_path(production)
  end

  def destroy
    Comment.find_by(id: params[:id]).destroy
    redirect_to production_path(params[:production_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end

end
