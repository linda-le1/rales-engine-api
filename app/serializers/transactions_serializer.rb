class TransactionsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :invoice_id, :result
end
