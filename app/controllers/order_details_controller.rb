class OrderDetailsController < ApplicationController
  before_action :logged_in_user, :normal_user?
  before_action :check_prod_and_curren_order_exits, except: [:show, :new]
  before_action :find_order_detail, only: [:edit, :update, :destroy]
  before_action :check_prod_exist_in_cart, only: [:create]
  after_action :update_total_pay, only: [:create, :update, :destroy]
  
  def index
    @order_details = @order.order_details
  end

  def create
    @order_detail = @order.order_details.build order_detail_params
    if @order_detail.save
      flash.now[:success] = t "order.create_succ"
      update_total_pay()
      respond_to do |format|
        format.html {redirect_to :back}
        format.js
      end
    else
      flash[:danger] = t "order.create_err"
      redirect_to products_path
    end
  end

  def edit
  end

  def update
    if @order_detail.update_attributes order_detail_params
      flash[:success] = t "order.update_succ"
      redirect_to order_path
    else
      flash[:danger] = t "order.update_err"
      redirect_to :edit
    end
  end

  def destroy
    if @order_detail.destroy
      flash[:success] = t "order.destroy_succ"
      redirect_to @order
    else
      flash[:danger] = t "order.destroy_err"
      redirect_to products_path
    end
  end

  private
  def check_prod_exist_in_cart
    if order_detail = @order.order_details.find_by(product_id: 
      params[:order_detail][:product_id])
      order_detail.update_attributes quantity: 
        (order_detail.quantity + params[:order_detail][:quantity].to_i)
      flash[:success] = t "order.count"
      update_total_pay()
      redirect_to :back
    end
  end

  def order_detail_params
    params.require(:order_detail).permit :quantity, :product_id
  end

  def check_prod_and_curren_order_exits
    if current_order.id = session[:order_id]
      @order = current_order
    else
      @order = Order.create user_id: current_user.id
      session[:order_id] = @order.id
    end
    if params[:order_detail]
      @product = Product.find_by id: params[:order_detail][:product_id]
      if @product.nil?
        flash[:danger] = t "flash.prod_nil"
        redirect_to root_path
      end
    end
  end

  def find_order_detail
    @order_detail = @order.order_details.find params[:id]
  end

  def update_total_pay
    current_order[:total_pay] = current_order.subtotal
    current_order.save
  end
end
