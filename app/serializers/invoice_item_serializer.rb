class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :item_id, :invoice_id, :quantity, :id, :unit_price
  belongs_to :item
  belongs_to :invoice
end
