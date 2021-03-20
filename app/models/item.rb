class Item < ApplicationRecord

  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_items

  attachment :image

  validetes :name, presence: true
  validates :introduction, presence: true
  validates :price, presense: true
  validates :is_active, presence: true

end
