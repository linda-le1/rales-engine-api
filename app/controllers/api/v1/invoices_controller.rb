class Api::V1::InvoicesController < ApplicationController
    before_action :set_merchant

    def index
        render json: InvoiceSerializer.new(@merchant.invoices)
    end

    private

    def set_merchant
        @merchant = Merchant.find(params[:merchant_id])
    end
end