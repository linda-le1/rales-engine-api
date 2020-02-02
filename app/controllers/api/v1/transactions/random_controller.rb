class Api::V1::Transactions::RandomController < ApplicationController

    def index
        render json: TransactionSerializer.new(Transaction.all.shuffle.first)
    end
end