require 'rails_helper'

describe 'Merchants' do
    it 'sends a list of merchants' do
        create_list(:merchant, 5)

        get '/api/v1/merchants'

        expect(response).to be_successful

        merchants = JSON.parse(response.body)["data"]

        expect(merchants.count).to eql(5)

    end

    it 'can get one merchant by its id' do
        id = create(:merchant).id

        get "/api/v1/merchants/#{id}"

        merchant = JSON.parse(response.body)['data']

        expect(response).to be_successful
        expect(merchant['attributes']['id']).to eq(id)
    end

    it 'can find a list of items from a specific merchant' do
        merchant_id = create(:merchant).id
        merchant_2_id = create(:merchant).id

        items = create_list(:item, 5, merchant_id: merchant_id)

        get "/api/v1/merchants/#{merchant_id}/items"

        items = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(items.count).to eql(5)
        expect(items.last['attributes']['merchant_id']).to_not be eql(merchant_2_id)
    end

    it 'can find a list of invoices from a specific merchant' do
        merchant_id = create(:merchant).id
        merchant_2_id = create(:merchant).id
        customer_id = create(:customer).id

        invoices = create_list(:invoice, 2, merchant_id: merchant_id, customer_id: customer_id)

        get "/api/v1/merchants/#{merchant_id}/invoices"

        invoices = JSON.parse(response.body)['data']

        expect(response).to be_successful
        expect(invoices.count).to eql(2)
        expect(invoices.last['attributes']['merchant_id']).to_not be eql(merchant_2_id)
    end

    it 'can find a merchant by their name' do

        merchant = create(:merchant, name: 'Baby Yoda Boba')

        get "/api/v1/merchants/find?name=#{merchant.name}"

        merchant = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(merchant['attributes']['name']).to eql('Baby Yoda Boba')
    end

    it 'can find a merchant by their id' do

        merchant = create(:merchant, id: 888)

        get "/api/v1/merchants/find?id=#{merchant.id}"

        merchant = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(merchant['attributes']['id']).to eql(888)
    end

    it 'can find a merchant by date created at' do

        merchant_1 = create(:merchant, created_at: "2009-01-31 01:30:08 UTC")
        merchant_2 = create(:merchant, created_at: "1998-04-22 01:30:08 UTC")

        get "/api/v1/merchants/find?created_at=#{merchant_1.created_at}"

        merchant = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(merchant['attributes']['id']).to eql(merchant_1.id)
    end

    it 'can find a merchant by date updated at' do

        merchant_1 = create(:merchant, updated_at: "2009-01-31 01:30:08 UTC")
        merchant_2 = create(:merchant, updated_at: "1998-04-22 01:30:08 UTC")

        get "/api/v1/merchants/find?updated_at=#{merchant_1.updated_at}"

        merchant = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(merchant['attributes']['id']).to eql(merchant_1.id)
    end

    it 'can find all merchants by name' do

        merchant_1 = create(:merchant, name: "Mojo Jojo")
        merchant_2 = create(:merchant, name: "Mojo Jojo")

        expect(merchant_1.id).not_to eql(merchant_2.id)

        get "/api/v1/merchants/find_all?name=Mojo+Jojo"

        merchants = JSON.parse(response.body)
        expect(response).to be_successful

        expect(merchants.count).to eql(2)
        expect(merchant_1.id).not_to eql(merchant_2.id)
    end
end