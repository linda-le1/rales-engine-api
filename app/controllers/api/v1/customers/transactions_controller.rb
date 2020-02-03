class Api::V1::Customers::TransactionsController < ApplicationController

    before_action :set_customer

    def index
        render json: TransactionSerializer.new(@customer.transactions)
    end

    private

    def set_customer
        @customer= Customer.find(params[:id])
    end
end