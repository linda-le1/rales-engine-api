class CustomerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :id, :created_at, :updated_at
  has_many :invoices
  has_many :transactions, through: :invoices
end
