class Api::V1::Items::MerchantController < ApplicationController

    before_action :set_item

    def index
        merchant = Merchant.find(@item.merchant_id)
        render json: MerchantSerializer.new(merchant)
    end

    private

    def set_item
        @item = Item.find(params[:id])
    end
end