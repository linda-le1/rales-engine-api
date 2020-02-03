class Api::V1::Invoices::TransactionsController < ApplicationController

    before_action :set_invoice

    def index
        render json: TransactionSerializer.new(@invoice.transactions)
    end

    private

    def set_invoice
        @invoice = Invoice.find(params[:id])
    end
end