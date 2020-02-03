class Api::V1::Merchants::MostRevenueController < ApplicationController

    def index
        quantity = params[:quantity].to_i
        render json: MerchantSerializer.new(Merchant.calculate_most_revenue(quantity))
    end

end


