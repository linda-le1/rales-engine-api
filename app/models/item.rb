class Item < ApplicationRecord
    belongs_to :merchant
    has_many :invoice_items, dependent: :destroy

    default_scope { order(:id) }
end
