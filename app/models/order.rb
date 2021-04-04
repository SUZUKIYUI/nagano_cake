class Order < ApplicationRecord

  has_many :order_items, dependent: :destroy
  belongs_to :customer

  validates :method_of_payment, presence: true
  validates :delivery_postal_code, presence: true
  validates :delivery_address, presence: true
  validates :delivery_addressee, presence: true

  enum method_of_payment:{
    credit:0,
    bank:1,
  }

  enum order_status:{
    waiting_for_payment:0,
    payment_confirmation:1,
    in_production:2,
    preparing_to_ship:3,
    shipped:4,
  }

end
