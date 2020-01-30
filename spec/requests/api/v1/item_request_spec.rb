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

        binding.pry

        expect(items.count).to eql(15)
    end

    it 'can get an item by its id' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        item_1 = create(:item, merchant_id: merchant.id)
        item_2 = create(:item, merchant_id: merchant_2.id)

        get "/api/v2/items/#{item_1.id}"

        expect(response).to be_successful

        item = JSON.parse(response.body)['data']

        expect(item.count).to eql(1)
        expect(item['attributes']['merchant_id'])
    end
end