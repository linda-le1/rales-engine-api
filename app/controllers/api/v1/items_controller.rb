class Api::V1::ItemsController < ApplicationController
    before_action :set_merchant

    def index
        render json: @merchant.items
    end

    private

    def set_merchant
        @merchant = Merchant.find(params[:merchant_id])
    end
end