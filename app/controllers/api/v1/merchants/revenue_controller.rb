class Api::V1::Merchants::RevenueController < ApplicationController

    def index
        json render: MerchantSerializer.new(Merchant.calculate_revenue_by_date(params[:date]))

    end

end

