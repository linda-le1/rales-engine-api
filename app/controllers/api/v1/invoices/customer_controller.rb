class Api::V1::Invoices::CustomerController < ApplicationController

    before_action :set_invoice

    def index
        customer = Customer.find(@invoice.customer_id)
        render json: CustomerSerializer.new(customer)
    end

    private

    def set_invoice
        @invoice = Invoice.find(params[:id])
    end
end