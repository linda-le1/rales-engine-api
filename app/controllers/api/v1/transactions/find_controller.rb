class Api::V1::Transactions::FindController < ApplicationController
    def index
        render json: TransactionSerializer.new(Transaction.find_by(request.query_parameters))
    end

end