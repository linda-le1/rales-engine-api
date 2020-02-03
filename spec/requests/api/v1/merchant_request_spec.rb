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
        merchant_3 = create(:merchant, name: "Baby Yoda Boba")

        expect(merchant_1.id).not_to eql(merchant_2.id)

        get "/api/v1/merchants/find_all?name=Mojo+Jojo"

        merchants = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(merchants.count).to eql(2)

        expect(merchants[0]['attributes']['id']).to eql(merchant_1.id)
        expect(merchants[1]['attributes']['id']).to eql(merchant_2.id)
    end

    it 'can find all merchants by id' do

        merchant_1 = create(:merchant, id: 1)
        merchant_2 = create(:merchant, id: 2)

        get "/api/v1/merchants/find_all?id=2"

        merchants = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(merchants.count).to eql(1)
        expect(merchants[0]['attributes']['id']).to eql(merchant_2.id)
    end

    it 'can find all merchants by date created at' do

        merchant_1 = create(:merchant, created_at: "2009-01-31 01:30:08 UTC")
        merchant_2 = create(:merchant, created_at: "1998-04-22 01:30:08 UTC")
        merchant_3 = create(:merchant, created_at: "2009-01-31 01:30:08 UTC")

        expect(merchant_1.id).not_to eql(merchant_3.id)

        get "/api/v1/merchants/find_all?created_at=2009-01-31 01:30:08 UTC"

        merchants = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(merchants.count).to eql(2)
        expect(merchants[0]['attributes']['id']).to eql(merchant_1.id)
        expect(merchants[1]['attributes']['id']).to eql(merchant_3.id)
    end

    it 'can find all merchants by updated at' do

        merchant_1 = create(:merchant, updated_at: "2009-01-31 01:30:08 UTC")
        merchant_2 = create(:merchant, updated_at: "1998-04-22 01:30:08 UTC")

        expect(merchant_1.id).not_to eql(merchant_2.id)

        get "/api/v1/merchants/find_all?updated_at=2009-01-31 01:30:08 UTC"

        merchants = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(merchants.count).to eql(1)
        expect(merchants[0]['attributes']['id']).to eql(merchant_1.id)
    end

    it 'can find merchants at random' do
        merchants = create_list(:merchant, 5)

        ids = merchants.map do |merchant|
                merchant.id
            end

        get '/api/v1/merchants/random'

        random_merchant = JSON.parse(response.body)

        expect(response).to be_successful

        expect(random_merchant.count).to eql(1)

        expect(ids).to include(random_merchant['data']['attributes']['id'])

    end

    it 'can find the top x merchants ranked by total revenue where transactions are successful' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        merchant_3 = create(:merchant)
        merchant_4 = create(:merchant)
        merchant_5 = create(:merchant)

        customer_1 = create(:customer)
        customer_2 = create(:customer)

        item_1 = create(:item, unit_price: 50, merchant_id: merchant_1.id)
        item_2 = create(:item, unit_price: 40, merchant_id: merchant_2.id)
        item_3 = create(:item, unit_price: 30, merchant_id: merchant_3.id)
        item_4 = create(:item, unit_price: 20, merchant_id: merchant_4.id)
        item_5 = create(:item, unit_price: 100, merchant_id: merchant_5.id)

        invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id)
        invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer_1.id)
        invoice_3 = create(:invoice, merchant_id: merchant_3.id, customer_id: customer_2.id)
        invoice_4 = create(:invoice, merchant_id: merchant_4.id, customer_id: customer_1.id)
        invoice_5 = create(:invoice, merchant_id: merchant_5.id, customer_id: customer_2.id)

        transaction_1 = create(:transaction, result: 'success', invoice_id: invoice_1.id)
        transaction_2 = create(:transaction, result: 'success', invoice_id: invoice_2.id)
        transaction_3 = create(:transaction, result: 'success', invoice_id: invoice_3.id)
        transaction_4 = create(:transaction, result: 'success', invoice_id: invoice_4.id)
        transaction_5 = create(:transaction, result: 'failed', invoice_id: invoice_5.id)

        invoice_item_1 = create(:invoice_item, quantity: 2, invoice_id: invoice_1.id, item_id: item_1.id)
        invoice_item_2 = create(:invoice_item, quantity: 2, invoice_id: invoice_2.id, item_id: item_2.id)
        invoice_item_3 = create(:invoice_item, quantity: 2, invoice_id: invoice_3.id, item_id: item_3.id)
        invoice_item_4 = create(:invoice_item, quantity: 2, invoice_id: invoice_4.id, item_id: item_4.id)
        invoice_item_5 = create(:invoice_item, quantity: 5, invoice_id: invoice_5.id, item_id: item_5.id)

        get '/api/v1/merchants/most_revenue?quantity=3'

        top_merchants = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(top_merchants.count). to eql(3)
        expect(top_merchants[0]["attributes"]["id"]).to eq(merchant_1.id)
        expect(top_merchants[1]["attributes"]["id"]).to eq(merchant_2.id)
        expect(top_merchants[2]["attributes"]["id"]).to eq(merchant_3.id)

    end

    it 'returns the total revenue for date x across all merchants' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        merchant_3 = create(:merchant)

        customer_1 = create(:customer)
        customer_2 = create(:customer)

        item_1 = create(:item, unit_price: 1000, merchant_id: merchant_1.id)
        item_2 = create(:item, unit_price: 1500, merchant_id: merchant_2.id)
        item_3 = create(:item, unit_price: 2001, merchant_id: merchant_3.id)

        invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id, created_at: "2020-01-31 10:20:30 UTC")
        invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer_1.id, created_at: "2020-01-31 10:20:30 UTC")
        invoice_3 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer_2.id, created_at: "2020-01-31 10:20:30 UTC")

        transaction_1 = create(:transaction, result: 'success', invoice_id: invoice_1.id)
        transaction_2 = create(:transaction, result: 'success', invoice_id: invoice_2.id)
        transaction_3 = create(:transaction, result: 'failed', invoice_id: invoice_3.id)

        invoice_item_1 = create(:invoice_item, quantity: 1, invoice_id: invoice_1.id, item_id: item_1.id, unit_price: item_1.unit_price)
        invoice_item_2 = create(:invoice_item, quantity: 1, invoice_id: invoice_2.id, item_id: item_2.id, unit_price: item_2.unit_price)
        invoice_item_3 = create(:invoice_item, quantity: 2, invoice_id: invoice_3.id, item_id: item_3.id, unit_price: item_3.unit_price)

        get '/api/v1/merchants/revenue?date=2020-01-31'
        revenue = JSON.parse(response.body)['data']
        
        expect(response).to be_successful

        expect(revenue['attributes']['total_revenue']).to eql ('25.00')
    end
end
