class Api::V1::Invoices::FindController < ApplicationController
    def index
        render json: InvoiceSerializer.new(Invoice.find_by(request.query_parameters))
    end

end