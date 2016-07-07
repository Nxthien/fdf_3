class OrdersController < ApplicationController
  before_action :logged_in_user, :normal_user?
  before_action :find_order, only: [:show, :update]
  before_action :correct_user, only: [:show, :update]

  def show
    @order_details = @order.order_details
      .paginate page: params[:page], per_page: Settings.size
  end

  def index
    @orders = Order.show(current_user.id).paginate page: params[:page], per_page: Settings.size
  end

  def update
    if @order.update_attributes order_params
      flash[:success] = t "order.ordered"
      redirect_to root_path
    end
    session.delete :order_id
    @current_order = nil
  end

  private
  def order_params
    params.require(:order).permit :status
  end

  def find_order
    @order = Order.find_by id: params[:id]
    if @order.nil?
      flash[:danger] = t "flash.order_nil"
      redirect_to admin_orders_path
    end
  end

  def correct_user
    order = Order.find_by id: params[:id]
    if order.nil?
      flash[:danger] = t "flash.order_nil"
      redirect_to root_path
    end
    unless order.user_id == current_user.id
      flash[:danger] = t "user.not_owner"
      redirect_to root_url
    end
  end
end
