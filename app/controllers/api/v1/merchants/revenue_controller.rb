class Api::V1::Merchants::RevenueController < ApplicationController

    def index
        MerchantSerializer.new(Merchant.select("merchants.*, sum(unit_price*quantity) as revenue")
        .joins(invoices: [:invoice_items, :transactions])
        .where(transactions: {result: 'success'})
        .group(:id)
        .order(revenue: :desc)
        .limit(3))
    end

end


