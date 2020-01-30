class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :item_id, :invoice_id, :quantity, :id

  attribute :unit_price do |invoice_item|
    invoice_item.unit_price / 100
  end

  belongs_to :item
  belongs_to :invoice
end
