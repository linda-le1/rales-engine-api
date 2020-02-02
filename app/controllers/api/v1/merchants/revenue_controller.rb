class Api::V1::Merchants::RevenueController < ApplicationController

    def index
        render json: MerchantSerializer.new(Merchant.select("merchants.*, sum(unit_price*quantity) as revenue")
        .joins(invoices: [:invoice_items, :transactions])
        .group(:id)
        .where(transactions: {result: 'success'})
        .order(revenue: :desc)
        .limit(3))
    end

end


