require 'rails_helper'

describe Item do
    it 'sends a list of all items' do

        create_list(:item, 5)

        get '/api/v1/merchants'

        expect(response).to be_successful

        merchants = JSON.parse(response.body)["data"]

        expect(merchants.count).to eql(5)

    end
end