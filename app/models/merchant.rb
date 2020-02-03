class Merchant < ApplicationRecord
    has_many :items, dependent: :destroy
    has_many :invoices, dependent: :destroy
    has_many :transactions, through: :invoices
    has_many :invoice_items, through: :invoices

    default_scope { order(:id) }

    def self.calculate_most_revenue(quantity)
        unscoped
        .select("merchants.*, sum(unit_price*quantity) as revenue")
        .group(:id)
        .joins(invoices: [:invoice_items, :transactions])
        .merge(Transaction.successful)
        .order(revenue: :desc)
        .limit(quantity)
    end

    def self.calculate_revenue_by_date(date)
        unscoped
        .select("date_trunc('day', invoices.created_at) as date,
            sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue")
        .group("date")
        .joins(invoices: [:invoice_items, :transactions])
        .merge(Transaction.successful)
        .order("total_revenue desc")
        .where(invoices: {created_at: (Time.zone.parse(date).all_day)})
    end

end
