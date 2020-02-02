class Api::V1::Items::RandomController < ApplicationController

    def index
        render json: ItemSerializer.new(Item.all.shuffle.first)
    end
end