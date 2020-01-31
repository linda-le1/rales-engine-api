class Api::V1::Merchants::MerchantInvoicesController < ApplicationController
    before_action :set_merchant

    def index
        render json: InvoiceSerializer.new(@merchant.invoices)
    end

    private

    def set_merchant
        @merchant = Merchant.find(params[:id])
    end
end