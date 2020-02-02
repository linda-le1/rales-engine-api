class Api::V1::Items::FindController < ApplicationController
    def index
        render json: ItemSerializer.new(Item.find_by(request.query_parameters))
    end

end