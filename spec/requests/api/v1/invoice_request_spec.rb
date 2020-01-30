require 'rails_helper'

describe 'Invoices' do
    it 'sends a list of all invoices' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        customer = create(:customer)
        customer_2 = create(:customer)

        create_list(:invoice, 5, merchant_id: merchant.id, customer_id: customer.id)
        create_list(:invoice, 4, merchant_id: merchant_2.id, customer_id: customer_2.id)

        get '/api/v1/invoices'

        expect(response).to be_successful

        invoices = JSON.parse(response.body)["data"]

        expect(invoices.count).to eql(9)
    end

    it 'can get an invoice by its id' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        customer = create(:customer)
        customer_2 = create(:customer)

        invoices = create_list(:invoice, 2, merchant_id: merchant_2.id, customer_id: customer_2.id)
        invoice_3 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

        get "/api/v1/invoices/#{invoice_3.id}"

        invoices = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(invoices['attributes']['merchant_id']).to eql(merchant.id)
        expect(invoices['attributes']['customer_id']).to eql(customer.id)
    end
end