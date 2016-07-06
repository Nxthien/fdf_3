class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :new_suggestion
  
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def logged_in
    if logged_in?
      flash[:danger] = t "login.logged"
      redirect_to root_path
    end
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "login.danger"
      redirect_to login_url
    end
  end

  def verify_admin
    unless current_user.admins?
      flash[:danger] = t "flash.not_admin"
      redirect_to root_path
    end
  end

  def normal_user?
    if current_user
      if current_user.admins?
        flash[:danger] = t "flash.is_admin"
        redirect_to root_path
      end
    end
  end

  def check_column order
    Product.column_names.include?(order) ? order : "created_at"
  end
  
  def check_direction direction
    "asc" == direction ? "desc" : "asc"
  end

  def check_status status
    Order.statuses.values.include?(status.to_i) ? status : 1
  end

  def order_prod obj
    obj.order_by(check_column(params[:order]),
      check_direction(params[:direction]))
      .paginate page: params[:page], per_page: Settings.size
  end

  def order_prod_rate obj
    obj.order_by_rate(check_direction params[:direction])
      .paginate page: params[:page], per_page: Settings.size
  end

  def order_prod_default obj
    obj.order_by("created_at", "desc")
      .paginate page: params[:page], per_page: Settings.size
  end

  def new_suggestion
    @suggestion = Suggestion.new
  end
end
