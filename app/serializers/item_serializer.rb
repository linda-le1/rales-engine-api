class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :merchant_id, :unit_price

  belongs_to :merchant
  has_many :invoice_items
end
