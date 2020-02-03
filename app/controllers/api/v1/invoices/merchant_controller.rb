class Api::V1::Invoices::MerchantController < ApplicationController

    before_action :set_invoice

    def index
        merchant = Merchant.find(@invoice.merchant_id)
        render json: MerchantSerializer.new(merchant)
    end

    private

    def set_invoice
        @invoice = Invoice.find(params[:id])
    end
end