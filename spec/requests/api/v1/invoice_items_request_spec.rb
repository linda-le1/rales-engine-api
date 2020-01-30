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

    it 'can get an invoice by its id' do
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

        invoice_item = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(invoice_item['attributes']['invoice_id']).to eql(invoice.id)
        expect(invoice_item['attributes']['item_id']).not_to eql(item_2.id)
    end
end