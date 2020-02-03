class Api::V1::Merchants::RevenueController < ApplicationController

    def index
        render json: MerchantRevenueSerializer.new(Merchant.calculate_revenue_by_date(params[:date]).first)
    end

end

