class Api::V1::Customers::FindController < ApplicationController
    def index
        render json: CustomerSerializer.new(Customer.find_by(request.query_parameters))
    end

end