class TransactionsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :invoice_id, :credit_card_number, :result
end
