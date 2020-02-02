class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :invoice_id, :credit_card_number, :result, :id, :created_at, :updated_at
  belongs_to :invoice
end
