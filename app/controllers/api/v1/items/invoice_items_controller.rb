class Api::V1::Items::InvoiceItemsController < ApplicationController

    before_action :set_item

    def index
        render json: InvoiceItemSerializer.new(@item.invoice_items)
    end

    private

    def set_item
        @item = Item.find(params[:id])
    end
end