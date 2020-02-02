class Invoice < ApplicationRecord
    belongs_to :merchant
    belongs_to :customer
    has_many :transactions, dependent: :destroy
    has_many :invoice_items, dependent: :destroy
    has_many :items, through: :invoice_items

    def parse_date(date)
        start = Time.zone.parse(date)
        over = start + 1.days
        {updated_at: start..over}
    end
end
