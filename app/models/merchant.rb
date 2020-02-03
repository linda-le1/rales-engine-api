class Merchant < ApplicationRecord
    has_many :items, dependent: :destroy
    has_many :invoices, dependent: :destroy
    has_many :transactions, through: :invoices
    has_many :invoice_items, through: :invoices

    def self.calculate_most_revenue(quantity)
        select("merchants.*, sum(unit_price*quantity) as revenue")
        .group(:id)
        .joins(invoices: [:invoice_items, :transactions])
        .merge(Transaction.successful)
        .order(revenue: :desc)
        .limit(quantity)
    end

    def self.calculate_revenue_by_date(date)
        select("sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
        .joins(invoices: [:invoice_items, :transactions])
        .merge(Transaction.successful)
        .where(invoices: {updated_at: (Time.zone.parse(date)..(Time.zone.parse(date)+1.days))})    .select("sum(unit_price*quantity) AS revenue")
    end

end
