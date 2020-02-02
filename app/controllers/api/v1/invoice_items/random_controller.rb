class Api::V1::InvoiceItems::RandomController < ApplicationController

    def index
        render json: InvoiceItemSerializer.new(InvoiceItem.all.shuffle.first)
    end
end