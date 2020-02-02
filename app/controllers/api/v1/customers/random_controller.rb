class Api::V1::Customers::RandomController < ApplicationController

    def index
        render json: CustomerSerializer.new(Customer.all.shuffle.first)
    end
end