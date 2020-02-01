class Api::V1::Merchants::RandomController < ApplicationController

    def index
        render json: MerchantSerializer.new(Merchant.all.shuffle.first)
    end
end