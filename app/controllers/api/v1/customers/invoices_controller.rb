class Api::V1::Customers::InvoicesController < ApplicationController
    before_action :set_customer

    def index
        render json: InvoiceSerializer.new(@customer.invoices)
    end

    private

    def set_customer
        @customer = Customer.find(params[:id])
    end
end