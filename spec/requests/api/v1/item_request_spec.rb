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

    it 'can get a specific item by its id' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        item_1 = create(:item, merchant_id: merchant.id)
        item_2 = create(:item, merchant_id: merchant_2.id)

        get "/api/v1/items/#{item_1.id}"

        expect(response).to be_successful

        item = JSON.parse(response.body)['data']

        expect(item['attributes']['merchant_id']).to eql(merchant.id)
        expect(item['attributes']['merchant_id']).not_to eql(merchant_2.id)
    end

    it 'can find an item by its id' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        item_1 = create(:item, merchant_id: merchant.id, id: 888)
        item_2 = create(:item, merchant_id: merchant_2.id, id: 444)

        get "/api/v1/items/find?id=#{item_1.id}"

        expect(response).to be_successful

        item = JSON.parse(response.body)['data']

        expect(item['attributes']['id']).to eql(item_1.id)
    end

    it 'can find an item by its merchant id' do
        merchant = create(:merchant, id: 111)
        merchant_2 = create(:merchant, id: 5)

        item_1 = create(:item, merchant_id: merchant.id)
        item_2 = create(:item, merchant_id: merchant_2.id)

        get "/api/v1/items/find?merchant_id=#{item_1.merchant_id}"

        expect(response).to be_successful

        item = JSON.parse(response.body)['data']

        expect(item['attributes']['merchant_id']).to eql(merchant.id)
        expect(item['attributes']['id']).to eql(item_1.id)
    end

    it 'can find an item by its name' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        item_1 = create(:item, merchant_id: merchant.id, name: "Master Pokeball")
        item_2 = create(:item, merchant_id: merchant_2.id, name: "Crayons")

        get "/api/v1/items/find?name=#{item_1.name}"

        expect(response).to be_successful

        item = JSON.parse(response.body)['data']

        expect(item['attributes']['name']).to eql(item_1.name)
        expect(item['attributes']['id']).to eql(item_1.id)

    end

    it 'can find an item by its description' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        item_1 = create(:item, merchant_id: merchant.id, description: "The very best!")
        item_2 = create(:item, merchant_id: merchant_2.id, description: "Meh!")

        get "/api/v1/items/find?description=#{item_1.id}"

        expect(response).to be_successful

        item = JSON.parse(response.body)['data']

        expect(item['attributes']['description']).to eql(item_1.description)
        expect(item['attributes']['id']).to eql(item_1.id)
    end

    it 'can get an item by its date created' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        item_1 = create(:item, merchant_id: merchant.id, created_at: "2003-04-22 01:30:08 UTC")
        item_2 = create(:item, merchant_id: merchant_2.id, created_at: "2019-01-31 01:30:08 UTC")

        get "/api/v1/items/find?updated_at=#{item_1.created_at}"

        expect(response).to be_successful

        item = JSON.parse(response.body)['data']

        expect(item['attributes']['id']).to eql(item_1.id)
    end

    it 'can get an item by its date updated' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        item_1 = create(:item, merchant_id: merchant.id, updated_at: "2003-04-22 01:30:08 UTC")
        item_2 = create(:item, merchant_id: merchant_2.id, updated_at: "2019-01-31 01:30:08 UTC")

        get "/api/v1/items/find?updated_at=#{item_1.updated_at}"

        expect(response).to be_successful

        item = JSON.parse(response.body)['data']

        expect(item['attributes']['id']).to eql(item_1.id)
    end

    it 'can get an item by its unit price' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        item_1 = create(:item, merchant_id: merchant.id, unit_price: 2500)
        item_2 = create(:item, merchant_id: merchant_2.id, unit_price: 10000)

        get "/api/v1/items/find?unit_price=#{item_1.unit_price}"

        expect(response).to be_successful

        item = JSON.parse(response.body)['data']

        expect(item['attributes']['unit_price']).to eql(20.00)
        expect(item['attributes']['id']).to eql(item_1.id)
    end
end