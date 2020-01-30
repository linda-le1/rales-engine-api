require 'rails_helper'

describe 'Items' do
    it 'sends a list of all items' do

        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        create_list(:item, 5, merchant_id: merchant.id)
        create_list(:item, 10, merchant_id: merchant_2.id)

        get '/api/v1/items'

        expect(response).to be_successful

        items = JSON.parse(response.body)["data"]

        expect(items.count).to eql(15)

    end
end