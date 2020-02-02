class Api::V1::Merchants::RevenueController < ApplicationController

    def index
        render json: MerchantSerializer.new(Merchant.calculate_most_revenue(params[:quantity]))
    end

end


