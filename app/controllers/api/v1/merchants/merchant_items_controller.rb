class Api::V1::Merchants::MerchantItemsController < ApplicationController

    before_action :set_merchant

    def index
        render json: ItemSerializer.new(@merchant.items)
    end

    private

    def set_merchant
        @merchant = Merchant.find(params[:id])
    end
end