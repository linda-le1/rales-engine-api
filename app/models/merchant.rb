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
        select("merchants.name, invoices.created_at as date, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
        .joins(invoices: [:invoice_items, :transactions])
        .group(:name, "date")
        .where(transactions: {result:"success"})
        .order('revenue desc')
        .where(invoices: {updated_at: date})
    end

    def parse_date(date)
        start = Time.zone.parse(date)
        over = start + 1.days
        {updated_at: start..over}
    end

end
