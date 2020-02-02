class Merchant < ApplicationRecord
    has_many :items, dependent: :destroy
    has_many :invoices, dependent: :destroy
    has_many :transactions, through: :invoices
    has_many :invoice_items, through: :invoices

    def self.calculate_most_revenue(quantity)
        select("merchants.*, sum(unit_price*quantity) as revenue")
        .joins(invoices: [:invoice_items, :transactions])
        .group(:id)
        .where(transactions: {result: 'success'})
        .order(revenue: :desc)
        .limit(quantity)
    end

    def self.calculate_revenue_by_date(date)
        select("merchant.name, invoice.created_at as date, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
        .joins([:invoices [:invoice_items, :transactions]])
        .group(merchant.name, "date")
        .where(transaction {result:"success"})
        .order('revenue desc')
        .where(Invoice.parse_date(date))
    end

    def parse_date(date)
        start = Time.zone.parse(date)
        over = start + 1.days
        {created_at: start..over}
    end
end
