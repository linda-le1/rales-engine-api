class Api::V1::InvoiceItems::InvoiceController < ApplicationController

    before_action :set_invoice_item

    def index
        invoice= Invoice.find(@invoice_item.invoice_id)
        render json: InvoiceSerializer.new(invoice)
    end

    private

    def set_invoice_item
        @invoice_item = InvoiceItem.find(params[:id])
    end
end