class Api::V1::Invoices::RandomController < ApplicationController

    def index
        render json: InvoiceSerializer.new(Invoice.all.shuffle.first)
    end
end