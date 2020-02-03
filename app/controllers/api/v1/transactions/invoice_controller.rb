class Api::V1::Transactions::InvoiceController < ApplicationController

    before_action :set_transaction

    def index
        invoice = Invoice.find(@transaction.invoice_id)
        render json: InvoiceSerializer.new(invoice)
    end

    private

    def set_transaction
        @transaction = Transaction.find(params[:id])
    end
end