require 'rails_helper'

describe 'Invoice Items' do
    it 'sends a list of all invoice items' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        customer = create(:customer)
        customer_2 = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer_2.id)
        invoice_2= create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id)

        item_1 = create(:item, merchant_id: merchant.id)
        item_2 = create(:item, merchant_id: merchant_2.id)

        create_list(:invoice_item, 5, invoice_id: invoice.id, item_id: item_1.id)
        create_list(:invoice_item, 10, invoice_id: invoice_2.id, item_id: item_2.id)

        get '/api/v1/invoice_items'

        expect(response).to be_successful

        invoice_items = JSON.parse(response.body)["data"]

        expect(invoice_items.count).to eql(15)
    end

    it 'can get a specific invoice item' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        customer = create(:customer)
        customer_2 = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer_2.id)
        invoice_2= create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id)

        item_1 = create(:item, merchant_id: merchant.id)
        item_2 = create(:item, merchant_id: merchant_2.id)

        invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id)
        invoice_item_2 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_2.id)

        get "/api/v1/invoice_items/#{invoice_item_1.id}"

        expect(response).to be_successful

        invoice_item = JSON.parse(response.body)["data"]

        expect(invoice_item['attributes']['id']).to eql(invoice_item_1.id)
    end

    it 'can get an invoice item by its id through a find method' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        customer = create(:customer)
        customer_2 = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer_2.id)
        invoice_2= create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id)

        item_1 = create(:item, merchant_id: merchant.id)
        item_2 = create(:item, merchant_id: merchant_2.id)

        invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id)
        invoice_item_2 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_2.id)

        get "/api/v1/invoice_items/find?id=#{invoice_item_1.id}"

        invoice_item = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(invoice_item['attributes']['id']).to eql(invoice_item_1.id)
        expect(invoice_item['attributes']['id']).not_to eql(invoice_item_2.id)
    end

    it 'can find an invoice item by an item id' do

        merchant = create(:merchant)

        customer = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

        item_1 = create(:item, merchant_id: merchant.id)

        invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id)

        get "/api/v1/invoice_items/find?item_id=#{item_1.id}"

        invoice_item = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(invoice_item['attributes']['item_id']).to eql(item_1.id)
    end

    it 'can find an invoice item by an invoice id' do

        merchant = create(:merchant)

        customer = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
        invoice_2 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

        item_1 = create(:item, merchant_id: merchant.id)
        item_2 = create(:item, merchant_id: merchant.id)

        invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id)
        invoice_item_2 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_2.id)

        get "/api/v1/invoice_items/find?invoice_id=#{invoice.id}"

        invoice_item = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(invoice_item['attributes']['invoice_id']).to eql(invoice.id)
        expect(invoice_item['attributes']['id']).to eql(invoice_item_1.id)
    end

    it 'can find an invoice item by quantity' do

        merchant = create(:merchant)

        customer = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

        item_1 = create(:item, merchant_id: merchant.id)

        invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id, quantity: 5)
        invoice_item_2 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id, quantity: 10)

        get "/api/v1/invoice_items/find?quantity=#{invoice_item_1.quantity}"

        invoice_item = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(invoice_item['attributes']['id']).to eql(invoice_item_1.id)
        expect(invoice_item['attributes']['quantity']).to eql(5)
    end

    it 'can find an invoice item by unit price' do

        merchant = create(:merchant)

        customer = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

        item_1 = create(:item, merchant_id: merchant.id)

        invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id, unit_price: 2000)

        get "/api/v1/invoice_items/find?unit_price=#{invoice_item_1.unit_price}"

        item_invoice = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(item_invoice['attributes']['id']).to eql(invoice_item_1.id)

        expect(item_invoice['attributes']['unit_price']).to eql("20.00")
    end

    it 'can find an item invoice by date created at' do

        merchant = create(:merchant)

        customer = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
        invoice_2 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

        item_1 = create(:item, merchant_id: merchant.id)

        invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id, created_at: "2009-01-31 01:30:08 UTC")
        invoice_item_2 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_1.id, created_at: "2019-04-22 01:30:08 UTC")

        get "/api/v1/invoice_items/find?created_at=#{invoice_item_1.created_at}"

        invoice_item = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(invoice_item['attributes']['id']).to eql(invoice_item_1.id)
    end

    it 'can find a invoice item by date updated at' do

        merchant = create(:merchant)

        customer = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
        invoice_2 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

        item_1 = create(:item, merchant_id: merchant.id)

        invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id, updated_at: "2009-01-31 01:30:08 UTC")
        invoice_item_2 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_1.id, updated_at: "2019-04-22 01:30:08 UTC")

        get "/api/v1/invoice_items/find?updated_at=#{invoice_item_1.updated_at}"

        invoice_item = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(invoice_item['attributes']['id']).to eql(invoice_item_1.id)
    end

    it 'can find invoice_items at random' do

        merchant = create(:merchant)

        customer = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

        item = create(:item, merchant_id: merchant.id)

        invoice_items = create_list(:invoice_item, 5, invoice_id: invoice.id, item_id: item.id)

        ids = invoice_items.map do |invoice_item|
                invoice_item.id
            end

        get '/api/v1/invoice_items/random'

        random_invoice_item = JSON.parse(response.body)

        expect(response).to be_successful

        expect(random_invoice_item.count).to eql(1)

        expect(ids).to include(random_invoice_item['data']['attributes']['id'])
    end

    it 'can get all invoice items by an id' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        customer = create(:customer)
        customer_2 = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer_2.id)
        invoice_2= create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id)

        item_1 = create(:item, merchant_id: merchant.id)
        item_2 = create(:item, merchant_id: merchant_2.id)

        invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id)
        invoice_item_2 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_2.id)

        get "/api/v1/invoice_items/find_all?id=#{invoice_item_1.id}"

        invoice_item = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(invoice_item.count).to eql(1)

        expect(invoice_item[0]['attributes']['id']).to eql(invoice_item_1.id)
    end

    it 'can find all invoice items by an item id' do

        merchant = create(:merchant)

        customer = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
        invoice_2 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

        item_1 = create(:item, merchant_id: merchant.id)

        invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id)
        invoice_item_2 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_1.id)

        get "/api/v1/invoice_items/find_all?item_id=#{item_1.id}"

        invoice_items = JSON.parse(response.body)['data']

        expect(invoice_items.count).to eql(2)

        expect(invoice_items[0]['attributes']['id']).to eql(invoice_item_1.id)
        expect(invoice_items[1]['attributes']['id']).to eql(invoice_item_2.id)
    end

    it 'can find all invoice items by an invoice id' do

        merchant = create(:merchant)

        customer = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

        item_1 = create(:item, merchant_id: merchant.id)
        item_2 = create(:item, merchant_id: merchant.id)

        invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id)
        invoice_item_2 = create(:invoice_item, invoice_id: invoice.id, item_id: item_2.id)

        get "/api/v1/invoice_items/find_all?invoice_id=#{invoice.id}"

        invoice_items = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(invoice_items.count).to eql(2)

        expect(invoice_items[0]['attributes']['id']).to eql(invoice_item_1.id)
        expect(invoice_items[1]['attributes']['id']).to eql(invoice_item_2.id)
    end

    it 'can find all invoice items by quantity' do

        merchant = create(:merchant)

        customer = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

        item_1 = create(:item, merchant_id: merchant.id)

        invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id, quantity: 5)
        invoice_item_2 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id, quantity: 5)
        invoice_item_3 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id, quantity: 1)

        get "/api/v1/invoice_items/find_all?quantity=#{invoice_item_1.quantity}"

        invoice_items = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(invoice_items.count).to eql(2)

        expect(invoice_items[0]['attributes']['id']).to eql(invoice_item_1.id)
        expect(invoice_items[1]['attributes']['id']).to eql(invoice_item_2.id)
    end

    it 'can find all invoice items by unit price' do

        merchant = create(:merchant)

        customer = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

        item_1 = create(:item, merchant_id: merchant.id)
        item_2 = create(:item, merchant_id: merchant.id)

        invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id, unit_price: 2456)
        invoice_item_2 = create(:invoice_item, invoice_id: invoice.id, item_id: item_2.id, unit_price: 2456)

        get "/api/v1/invoice_items/find_all?unit_price=#{invoice_item_1.unit_price}"

        invoice_items = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(invoice_items.count).to eql(2)

        expect(invoice_items[0]['attributes']['id']).to eql(invoice_item_1.id)

        expect(invoice_items[1]['attributes']['id']).to eql(invoice_item_2.id)
    end

    it 'can find an item invoice by date created at' do

        merchant = create(:merchant)

        customer = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
        invoice_2 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

        item_1 = create(:item, merchant_id: merchant.id)
        item_2 = create(:item, merchant_id: merchant.id)

        invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id, created_at: "2009-01-31 01:30:08 UTC")
        invoice_item_2 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_2.id, created_at: "2019-04-22 01:30:08 UTC")
        invoice_item_3 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_1.id, created_at: "2019-04-22 01:30:08 UTC")

        get "/api/v1/invoice_items/find_all?created_at=#{invoice_item_2.created_at}"

        invoice_items = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(invoice_items.count).to eql (2)

        expect(invoice_items[0]['attributes']['id']).to eql(invoice_item_2.id)
        expect(invoice_items[1]['attributes']['id']).to eql(invoice_item_3.id)
    end

    it 'can find a invoice item by date updated at' do

        merchant = create(:merchant)

        customer = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
        invoice_2 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

        item_1 = create(:item, merchant_id: merchant.id)
        item_2 = create(:item, merchant_id: merchant.id)

        invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id, updated_at: "2009-01-31 01:30:08 UTC")
        invoice_item_2 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_2.id, updated_at: "2019-04-22 01:30:08 UTC")
        invoice_item_3 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_1.id, updated_at: "2019-04-22 01:30:08 UTC")

        get "/api/v1/invoice_items/find_all?updated_at=#{invoice_item_2.updated_at}"

        invoice_items = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(invoice_items.count).to eql (2)

        expect(invoice_items[0]['attributes']['id']).to eql(invoice_item_2.id)
        expect(invoice_items[1]['attributes']['id']).to eql(invoice_item_3.id)
    end

    it 'can return the associated invoice' do

        merchant = create(:merchant)

        customer = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
        invoice_2 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

        item_1 = create(:item, merchant_id: merchant.id)
        item_2 = create(:item, merchant_id: merchant.id)

        invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id)
        invoice_item_2 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_2.id)


        get "/api/v1/invoice_items/#{invoice_item_1.id}/invoice"

        invoice_item = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(invoice_item['attributes']['id']).to eql(invoice.id)
    end

end