class CommentsController < ApplicationController
  before_action :logged_in_user, :normal_user?

  def create
    @comment = Comment.new comment_params
    @product = Product.find_by id: @comment.product_id
    @comments = @product.comments.order_by_time
    unless @comment.save
      flash[:danger] = t "flash.comment"
    end
    respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end 
  end

  def destroy  
    @comment = current_user.comments.find params[:id]
    if @current_user.comments.nil?
      flash[:danger] = t "flash.user_nil"
      redirect_to root_path
    end
    @product = Product.find_by id: @comment.product_id
    @comments = @product.comments.order_by_time
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit :content, :user_id, :product_id
  end
end
