class Api::V1::Merchants::FindController < ApplicationController
    def index
        merchant_params = request.query_parameters
        render json: MerchantSerializer.new(Merchant.where(merchant_params))
    end
end

