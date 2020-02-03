class Api::V1::Invoices::ItemsController < ApplicationController

    before_action :set_invoice

    def index
        render json: ItemSerializer.new(@invoice.items)
    end

    private

    def set_invoice
        @invoice = Invoice.find(params[:id])
    end
end