class Api::V1::InvoiceItems::FindController < ApplicationController
    def index
        render json: InvoiceItemSerializer.new(InvoiceItem.find_by(request.query_parameters))
    end

end