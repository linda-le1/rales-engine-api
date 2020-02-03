class Api::V1::InvoiceItems::ItemController < ApplicationController

    before_action :set_invoice_item

    def index
        item= Item.find(@invoice_item.item_id)
        render json: ItemSerializer.new(item)
    end

    private

    def set_invoice_item
        @invoice_item = InvoiceItem.find(params[:id])
    end
end