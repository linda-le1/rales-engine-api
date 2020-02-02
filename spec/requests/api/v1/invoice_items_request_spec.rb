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

    it 'can get an invoice item by its id' do
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

end