class Order < ActiveRecord::Base
  belongs_to :user
  
  has_many :order_details, dependent: :destroy

  before_create :init_order
  before_save :update_subtotal

  scope :order_by_status, -> (status) {where status: status}
  scope :show, -> (ids) {where "id in (select id from orders where user_id = '#{ids}')"}

  enum status: ["blank", "ordered", "shipping", "delivered"]

  def subtotal
    order_details.collect {|od| od.valid? ? (od.quantity * od.unit_price) : 0}.sum
  end

  private
  def init_order
    self.status = 0
    self.total_pay = 0
  end

  def update_subtotal
    self[:total_pay] = subtotal
  end
end
