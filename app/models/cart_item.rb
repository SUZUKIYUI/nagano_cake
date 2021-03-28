class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :genre

  validates :amount, presence: true
  validates :item_id, presence: true

end
